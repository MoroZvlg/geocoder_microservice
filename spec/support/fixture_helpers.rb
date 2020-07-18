module FixtureHelpers
  def fixture_path
    path = File.expand_path("spec/fixtures")
    # Dir["#{path}**/*.rb"].each {|file| require file }
    path
  end
end