Return-Path: <SRS0=/rDn=MX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158AC677FC
	for <backports@archiver.kernel.org>; Thu, 11 Oct 2018 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B9620652
	for <backports@archiver.kernel.org>; Thu, 11 Oct 2018 20:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B9620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbeJLE0w convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:26:52 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40360 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbeJLE0w (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 12 Oct 2018 00:26:52 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2ADE92B25B
        for <backports@vger.kernel.org>; Thu, 11 Oct 2018 20:57:52 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 1C89C2C14E; Thu, 11 Oct 2018 20:57:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 201383] New: Intel AC9260 wifi does not get DHCP IP - SuSE 15
 kernel 4.12.14-25.16-default
Date:   Thu, 11 Oct 2018 20:57:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pradhan@hpe.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-201383-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=201383

            Bug ID: 201383
           Summary: Intel AC9260 wifi does not get DHCP IP - SuSE 15
                    kernel 4.12.14-25.16-default
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.12.14-25.16-default
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: pradhan@hpe.com
        Regression: No

4.12.14-25.16-default #1 SMP Thu Aug 23 10:02:38 UTC 2018 (a5893c4) x86_64
x86_64 x86_64 GNU/Linux


Followed the below steps to configure, however not receiving IPv4 IP address
from the router. Please suggest.

Steps:
=====
•       Installed iw and wpa_supplicant packages.
•       Verified the presence of the card
sles15sp0:linux_test>dmesg | grep 9260
[   74.125592] iwlwifi 0000:06:00.0: Detected Intel(R) Dual Band Wireless AC
9260, REV=0x324
•       Verified SLES image rev
sles15sp0:linux_test>uname -a
Linux sles15sp0 4.12.14-25.16-default #1 SMP Thu Aug 23 10:02:38 UTC 2018
(a5893c4) x86_64 x86_64 x86_64 GNU/Linux
You have new mail in /var/mail/root
sles15sp0:linux_test>
•       Looked for the wireless interface in the system and brought it up
sles15sp0:linux_test>iw dev
phy#0
        Interface wlan0
                ifindex 6
                wdev 0x1
                addr 94:b8:6d:87:4b:1e
                type managed
You have new mail in /var/mail/root
sles15sp0:linux_test>ip link show wlan0
6: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT
group default qlen 1000
    link/ether 94:b8:6d:87:4b:1e brd ff:ff:ff:ff:ff:ff

sles15sp0:linux_test>ip link set wlan0 up

sles15sp0:linux_test>ip link show wlan0

6: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode
DEFAULT group default qlen 1000
    link/ether 94:b8:6d:87:4b:1e brd ff:ff:ff:ff:ff:ff
sles15sp0:linux_test>iw wlan0 link
Not connected.

•       Scanned for available wifi access points and verified that security
type = PSK
sles15sp0:linux_test>iw wlan0 scan | fgrep -i ssid
        SSID: NETGEAR48-5G-2
        SSID: NETGEAR48
        SSID: Verizon-MiFi5510L-EFC7
        SSID: NETGEAR48-5G-1
sles15sp0:linux_test>iw wlan0 scan | fgrep -i Authentication
                 * Authentication suites: PSK
                 * Authentication suites: PSK
                 * Authentication suites: PSK
                 * Authentication suites: PSK

•       Created a WPA configuration file

sles15sp0:linux_test>wpa_passphrase NETGEAR48 smoothgiant416 > wpa.conf
sles15sp0:linux_test>cat wpa.conf
network={
        ssid="NETGEAR48"
        #psk="smoothgiant416"
        psk=61d3dc46d102862ce4077862bc2f04d060b4b882deff43bbe4b10d8a4a041138
}

•       Looked up the drivers present in the system and ran wpa_supplicant
sles15sp0:linux_test>lsmod | grep -e Used -e iwl
Module                  Size  Used by
iwlmvm                425984  0
mac80211              888832  1 iwlmvm
iwlwifi               258048  1 iwlmvm
cfg80211              696320  3 iwlmvm,iwlwifi,mac80211
You have new mail in /var/mail/root

sles15sp0:linux_test>wpa_supplicant -B -Dcfg80211 -iwlan0 -c ./wpa.conf
Successfully initialized wpa_supplicant
wlan0: Unsupported driver 'cfg80211'

sles15sp0:linux_test>wpa_supplicant -B -Dwext -iwlan0 -c /tmp/wpa.conf
Successfully initialized wpa_supplicant

•       Checking if the association between Wifi AP ( our lab router ) and
wlan0 (wifi interface) is in place.

sles15sp0:linux_test>iw dev wlan0 link
Connected to cc:40:d0:83:49:c1 (on wlan0)
        SSID: NETGEAR48
        freq: 2412
        RX: 2927 bytes (49 packets)
        TX: 1941 bytes (20 packets)
        signal: -62 dBm
        tx bitrate: 14.4 MBit/s MCS 8 short GI

        bss flags:      CTS-protection short-preamble short-slot-time
        dtim period:    2
        beacon int:     200
You have new mail in /var/mail/root

sles15sp0:linux_test>iw dev wlan0 info
Interface wlan0
        ifindex 6
        wdev 0x1
        addr 94:b8:6d:87:4b:1e
        ssid NETGEAR48
        type managed
        wiphy 0
        channel 1 (2412 MHz), width: 20 MHz, center1: 2412 MHz
sles15sp0:linux_test>

•       Try to obtain a DHCP IP from router.
•       This is where the problem lies, even if we are associated with the
access point we are not getting an IP(IPV4)  back from router
sles15sp0:linux_test>dhclient wlan0
You have new mail in /var/mail/root

sles15sp0:linux_test>ip addr show wlan0
6: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group
default qlen 1000
    link/ether 94:b8:6d:87:4b:1e brd ff:ff:ff:ff:ff:ff
    inet6 fe80::96b8:6dff:fe87:4b1e/64 scope link
       valid_lft forever preferred_lft forever
sles15sp0:linux_test>

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
