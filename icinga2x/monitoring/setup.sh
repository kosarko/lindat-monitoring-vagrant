#!/bin/bash
#install prerequisites
yum install -q -y perl-libwww-perl perl-Switch perl-LWP-Protocol-https
pushd /tmp
wget -q -O "html-xml-utils.rpm" "ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/TrevorBl/CentOS_CentOS-6/x86_64/html-xml-utils-6.9-4.1.x86_64.rpm" && yum install -q -y html-xml-utils.rpm
popd

#git clone
REPO_URL=https://github.com/ufal/lindat-monitoring.git
pushd /opt
git clone $REPO_URL lindat-monitoring
echo 'include_recursive "/opt/lindat-monitoring/ufal.d"' >> /etc/icinga2/icinga2.conf
echo 'const LindatPluginDir = "/opt/lindat-monitoring/plugins"' >> /etc/icinga2/conf.d/constants.conf
popd

#restart
systemctl restart icinga2
