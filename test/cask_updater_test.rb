# frozen_string_literal: true

require "json"
require "minitest/autorun"
require_relative "../script/lib/cask_updater"

class CaskUpdaterTest < Minitest::Test
  CODEXPLUSPLUS = CaskUpdater::Config.new(
    token: "codexplusplus",
    repository: "BigPizzaV3/CodexPlusPlus",
    asset_prefix: "CodexPlusPlus",
    extension: "dmg",
    cask_path: "/tmp/codexplusplus.rb",
  )
  CODEXTOOLS = CaskUpdater::Config.new(
    token: "codextools",
    repository: "hereww/codextools",
    asset_prefix: "ChatGPT-Codex-Tools",
    extension: "zip",
    cask_path: "/tmp/codextools.rb",
  )
  CASK = <<~RUBY
    cask "example" do

      version "1.2.4"
      sha256 arm:   "old-arm",
             intel: "old-intel"
      url "https://example.test/v\#{version}/app-\#{arch}.zip"
    end
  RUBY

  def test_parses_exact_codexplusplus_dmg_assets
    release = CaskUpdater.release_from(release_json(CODEXPLUSPLUS), CODEXPLUSPLUS)

    assert_equal "1.2.5", release.fetch(:version)
    assert_equal "https://example.test/arm.dmg", release.dig(:assets, :arm)
    assert_equal "https://example.test/intel.dmg", release.dig(:assets, :intel)
  end

  def test_parses_exact_codextools_zip_assets
    release = CaskUpdater.release_from(release_json(CODEXTOOLS), CODEXTOOLS)

    assert_equal "1.2.5", release.fetch(:version)
    assert_equal "https://example.test/arm.zip", release.dig(:assets, :arm)
    assert_equal "https://example.test/intel.zip", release.dig(:assets, :intel)
  end

  def test_rejects_draft_and_prerelease_releases
    [
      release_json(CODEXTOOLS, draft: true),
      release_json(CODEXTOOLS, prerelease: true),
    ].each do |json|
      error = assert_raises(CaskUpdater::UpdateError) do
        CaskUpdater.release_from(json, CODEXTOOLS)
      end
      assert_match(/stable/, error.message)
    end
  end

  def test_rejects_release_with_a_missing_required_asset
    assets = release_assets(CODEXTOOLS).reject { |asset| asset.fetch(:name).include?("x64") }

    error = assert_raises(CaskUpdater::UpdateError) do
      CaskUpdater.release_from(release_json(CODEXTOOLS, assets: assets), CODEXTOOLS)
    end

    assert_match(/macos-x64\.zip/, error.message)
  end

  def test_renders_metadata_without_changing_layout_or_url
    release = CaskUpdater.release_from(release_json(CODEXTOOLS), CODEXTOOLS)
    rendered = CaskUpdater.render(CASK, release, arm: "new-arm", intel: "new-intel")

    assert_includes rendered, 'version "1.2.5"'
    assert_includes rendered, "do\n\n  version"
    assert_includes rendered, 'sha256 arm:   "new-arm",'
    assert_includes rendered, 'intel: "new-intel"'
    assert_includes rendered, 'url "https://example.test/v#{version}/app-#{arch}.zip"'
    refute_includes rendered, "old-arm"
    refute_includes rendered, "old-intel"
  end

  def test_authenticates_github_api_without_leaking_token_to_asset_hosts
    api_headers = CaskUpdater.request_headers(
      URI("https://api.github.com/repos/example/project/releases/latest"),
      token: "workflow-token",
      accept: "application/vnd.github+json",
    )
    asset_headers = CaskUpdater.request_headers(
      URI("https://release-assets.githubusercontent.com/file.zip"),
      token: "workflow-token",
    )

    assert_equal "Bearer workflow-token", api_headers.fetch("Authorization")
    assert_equal "application/vnd.github+json", api_headers.fetch("Accept")
    refute asset_headers.key?("Authorization")
  end

  private

  def release_json(config, draft: false, prerelease: false, assets: release_assets(config))
    JSON.generate(
      tag_name: "v1.2.5",
      draft: draft,
      prerelease: prerelease,
      assets: assets,
    )
  end

  def release_assets(config)
    [
      {
        name: config.asset_name("1.2.5", "arm64"),
        browser_download_url: "https://example.test/arm.#{config.extension}",
      },
      {
        name: config.asset_name("1.2.5", "x64"),
        browser_download_url: "https://example.test/intel.#{config.extension}",
      },
      {
        name: "unrelated-windows.zip",
        browser_download_url: "https://example.test/windows.zip",
      },
    ]
  end
end
