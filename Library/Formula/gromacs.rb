require 'formula'

class Gromacs < Formula
  homepage 'http://www.gromacs.org/'
  url 'ftp://ftp.gromacs.org/pub/gromacs/gromacs-4.6-beta2.tar.gz'
  md5 'e2c393e6183a40fa734d150800c7e163'
  version '4.6'

  option 'enable-double', 'Enable double precision'

  depends_on :x11
  depends_on 'fftw'
  depends_on 'cmake'

  def install
    args = std_cmake_args
    args << '-DGMX_GPU=OFF'
    args << 'DGMX_OPENMP=OFF'
    args << '-DGMX_DOUBLE=ON' if build.include? 'enable-double'
    args << '..'

    mkdir 'build' do
      system 'cmake', *args
      system 'make'
      system 'make install'
    end
  end

  def test
    system "grompp -h"
  end
end
