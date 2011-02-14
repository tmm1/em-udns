require "mkmf"
require "fileutils"

def sys(cmd)
  puts "  -- #{cmd}"
  unless ret = xsystem(cmd)
    raise "#{cmd} failed, please report to https://github.com/ibc/em-udns/issues"
  end
  ret
end

here = File.expand_path('../', __FILE__)
udns_tarball = Dir["#{here}/udns-*.tar.gz"].first
udns_path = File.basename(udns_tarball, '.tar.gz')

Dir.chdir(here) do
  sys("tar zxvf #{udns_tarball}")

  Dir.chdir(udns_path) do
    sys("./configure")
    sys("make libudns.a")

    FileUtils.cp 'libudns.a', here
    FileUtils.cp 'udns.h', here
  end
end

have_library("udns")  # == -ludns
create_makefile("em_udns_ext")
