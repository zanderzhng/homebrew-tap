# frozen_string_literal: true

require "json"
require "minitest/autorun"
load File.expand_path("../script/update-codexplusplus", __dir__)

class CodexPlusPlusUpdaterTest < Minitest::Test
  CASK = <<~RUBY
    cask "codexplusplus" do
      version "1.2.35"
      sha256 arm:   "old-arm",
             intel: "old-intel"
      url "https://example.test/v\#{version}/app-\#{arch}.dmg"
    end
  RUBY

  def test_parses_stable_release_and_exact_architecture_assets
    release = CodexPlusPlusUpdater.release_from(release_json)

    assert_equal "1.2.36", release.fetch(:version)
    assert_equal "https://example.test/arm.dmg", release.dig(:assets, :arm)
    assert_equal "https://example.test/intel.dmg", release.dig(:assets, :intel)
  end

  def test_rejects_draft_and_prerelease_releases
    error = assert_raises(CodexPlusPlusUpdater::UpdateError) do
      CodexPlusPlusUpdater.release_from(release_json(draft: true))
    end
    assert_match(/stable/, error.message)

    error = assert_raises(CodexPlusPlusUpdater::UpdateError) do
      CodexPlusPlusUpdater.release_from(release_json(prerelease: true))
    end
    assert_match(/stable/, error.message)
  end

  def test_rejects_release_with_a_missing_required_asset
    assets = release_assets.reject { |asset| asset.fetch(:name).include?("x64") }

    error = assert_raises(CodexPlusPlusUpdater::UpdateError) do
      CodexPlusPlusUpdater.release_from(release_json(assets: assets))
    end

    assert_match(/macos-x64\.dmg/, error.message)
  end

  def test_renders_version_and_both_checksums_without_changing_url
    release = CodexPlusPlusUpdater.release_from(release_json)
    rendered = CodexPlusPlusUpdater.render(
      CASK,
      release,
      arm: "new-arm",
      intel: "new-intel",
    )

    assert_includes rendered, 'version "1.2.36"'
    assert_includes rendered, 'sha256 arm:   "new-arm",'
    assert_includes rendered, 'intel: "new-intel"'
    assert_includes rendered, 'url "https://example.test/v#{version}/app-#{arch}.dmg"'
    refute_includes rendered, "old-arm"
    refute_includes rendered, "old-intel"
  end

  private

  def release_json(draft: false, prerelease: false, assets: release_assets)
    JSON.generate(
      tag_name: "v1.2.36",
      draft: draft,
      prerelease: prerelease,
      assets: assets,
    )
  end

  def release_assets
    [
      {
        name: "CodexPlusPlus-1.2.36-macos-arm64.dmg",
        browser_download_url: "https://example.test/arm.dmg",
      },
      {
        name: "CodexPlusPlus-1.2.36-macos-x64.dmg",
        browser_download_url: "https://example.test/intel.dmg",
      },
      {
        name: "CodexPlusPlus-1.2.36-windows-x64.zip",
        browser_download_url: "https://example.test/windows.zip",
      },
    ]
  end
end
