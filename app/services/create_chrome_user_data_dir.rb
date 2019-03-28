class CreateChromeUserDataDir < ServiceBase
  def initialize
    @dir = nil
  end
 
  def call
    @dir = File.join(Dir.pwd, %w(tmp chrome))
    FileUtils.mkdir_p @dir
    @dir
  end
end
