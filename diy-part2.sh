#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
ZZZ=package/lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate   # 修改默认ip
sed -i 's/\/bin\/ash/\/bin\/bash/' package/base-files/files/etc/passwd    # 替换终端为bash
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile   # 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile   # 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-ssl-nginx/Makefile   # 选择argon为默认主题
rm -rf package/lean/luci-theme-argon    # 删除自带argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon    # 替换新版argon
sed -i 's/+uhttpd +uhttpd-mod-ubus //g' feeds/luci/collections/luci/Makefile    # 删除uhttpd
sed -i "s/OpenWrt /$DISTRIB_DESCRIPTION/g" $ZZZ    # 增加个性名字 ${Author} 默认为你的github帐号
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ    # 设置密码为空
sed -i 's/PATCHVER:=5.4/PATCHVER:=5.10/g' target/linux/x86/Makefile   # x86机型,默认内核5.4，修改内核为5.10
