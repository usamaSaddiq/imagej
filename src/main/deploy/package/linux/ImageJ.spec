Summary: ImageJ
Name: imagej
Version: 1.0
Release: 1
License: BSD-2-clause
Vendor: ImageJ
Prefix: /opt
Provides: imagej
Requires: ld-linux.so.2 libX11.so.6 libXext.so.6 libXi.so.6 libXrender.so.1 libXtst.so.6 libasound.so.2 libc.so.6 libdl.so.2 libgcc_s.so.1 libm.so.6 libpthread.so.0 libthread_db.so.1
Autoprov: 0
Autoreq: 0

#avoid ARCH subfolder
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm

#comment line below to enable effective jar compression
#it could easily get your package size from 40 to 15Mb but 
#build time will substantially increase and it may require unpack200/system java to install
%define __jar_repack %{nil}

%description
ImageJ

%prep

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/opt
cp -r %{_sourcedir}/ImageJ %{buildroot}/opt

%files

/opt/ImageJ

%post


xdg-desktop-menu install --novendor /opt/ImageJ/ImageJ.desktop

if [ "false" = "true" ]; then
    cp /opt/ImageJ/imagej.init /etc/init.d/imagej
    if [ -x "/etc/init.d/imagej" ]; then
        /sbin/chkconfig --add imagej
        if [ "false" = "true" ]; then
            /etc/init.d/imagej start
        fi
    fi
fi

%preun

xdg-desktop-menu uninstall --novendor /opt/ImageJ/ImageJ.desktop

if [ "false" = "true" ]; then
    if [ -x "/etc/init.d/imagej" ]; then
        if [ "true" = "true" ]; then
            /etc/init.d/imagej stop
        fi
        /sbin/chkconfig --del imagej
        rm -f /etc/init.d/imagej
    fi
fi

%clean
