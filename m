Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF3CC433E0
	for <backports@archiver.kernel.org>; Tue, 22 Dec 2020 09:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A7F22AAA
	for <backports@archiver.kernel.org>; Tue, 22 Dec 2020 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLVJDn convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Tue, 22 Dec 2020 04:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgLVJDl (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 22 Dec 2020 04:03:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0472522AAA
        for <backports@vger.kernel.org>; Tue, 22 Dec 2020 09:03:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 210845] New: QCA9558 failed init in calibration
Date:   Tue, 22 Dec 2020 09:02:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kmwestwind@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-210845-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210845

            Bug ID: 210845
           Summary: QCA9558 failed init in calibration
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.4.194
          Hardware: Mips32
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: kmwestwind@gmail.com
        Regression: No

Created attachment 294293
  --> https://bugzilla.kernel.org/attachment.cgi?id=294293&action=edit
system log

Use backports-4.19.137-1 on SoC QCA9558 as 2.4G wifi and QCA9880 as 5G wifi,now
the 5G wifi works find.2.4G can work with officail firmware with old Linux
kernel V2.xxx.
After flash with LEDE(openwrt)V17,the 2.4G wifi can't init with calibration in
ath9k_hw_reset() of hw.c,the device just REBOOT in function:
//      if (!ath9k_hw_init_cal(ah, chan))
//              return -EIO;
with remark two lines code above, device init ok,but can not work.then turn on
debug flags with 0xffffffff, log shows:

Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961614] ath: phy5: Reset TX
queue: 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961634] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961647] ath: phy5: Reset TX
queue: 1
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961665] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961676] ath: phy5: Reset TX
queue: 2
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961691] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961702] ath: phy5: Reset TX
queue: 3
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961716] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961729] ath: phy5: Reset
TXQ, inactive queue: 4
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961740] ath: phy5: Reset
TXQ, inactive queue: 5
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961751] ath: phy5: Reset
TXQ, inactive queue: 6
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961762] ath: phy5: Reset TX
queue: 7
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961780] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961791] ath: phy5: Reset TX
queue: 8
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961814] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961825] ath: phy5: Reset TX
queue: 9
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961845] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961863] ath: phy5: ver
1024.0 opmode 3 chan 2432 Mhz
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961882] ath: phy5:
ah->misc_mode 0x1000000c
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.961975] ath: phy5: TS Start
0xe198000 End 0xe19c800 Virt ae198000, Size 512
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.962331] ath: phy5: Begin
init_cal by xiang
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.966844] It's QCA9550 in calib
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.981715] ERROR in CALIB
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.984470] ath: phy5: Timeout
while waiting for nf to load: AR_PHY_AGC_CONTROL=0x50d5a
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.984487] ath: phy5: Enabled
BB Watchdog timeout (25 ms)
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.984504] ath: phy5: Reset to
2432 MHz, HT40: 0 fastcc: 0 return 0
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.990942] ath: phy5: Begin
complete reset
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995204] ath: phy5: disable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995217] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995229] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995242] ath: phy5: Do not
enable IER ref count -1
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995253] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995264] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995280] ath: phy5: macaddr:
14:3d:f2:ca:c8:14, bssid: 00:00:00:00:00:00, bssidmask: ff:ff:ff:ff:ff:ff
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995436] ath: phy5: Enable
MIB counters
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995457] ath: phy5: ****
ofdmlevel 3=>3, rssi=0[lo=7 hi=40]
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.995472] ath: phy5: ****
ccklevel 2=>2, rssi=0[lo=7 hi=40]
Tue Dec 22 16:59:50 2020 kern.warn kernel: [29931.995490] ******JUMP OFF
ANI******
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.999121] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.999132] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.999143] ath: phy5: enable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29931.999156] ath: phy5: AR_IMR
0x81800175 IER 0x1
Tue Dec 22 16:59:50 2020 kern.err kernel: [29931.999170] ath: phy5: END
complete reset
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003280] ath: phy5: New
interrupt mask 0xf0000443
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003292] ath: phy5: new IMR
0x81800145
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003304] ath: phy5: disable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003419] ath: phy5: TPC[00]
0x0000002c
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003434] ath: phy5: TPC[01]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003446] ath: phy5: TPC[02]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003458] ath: phy5: TPC[03]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003470] ath: phy5: TPC[04]
0x0000002e
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003482] ath: phy5: TPC[05]
0x0000002e
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003493] ath: phy5: TPC[06]
0x0000002e
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003505] ath: phy5: TPC[07]
0x0000002e
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003517] ath: phy5: TPC[08]
0x0000002d
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003529] ath: phy5: TPC[09]
0x0000002c
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003540] ath: phy5: TPC[10]
0x0000002b
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003552] ath: phy5: TPC[11]
0x00000027
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003564] ath: phy5: TPC[12]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003575] ath: phy5: TPC[13]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003587] ath: phy5: TPC[14]
0x0000002a
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003598] ath: phy5: TPC[15]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003610] ath: phy5: TPC[16]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003622] ath: phy5: TPC[17]
0x00000024
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003633] ath: phy5: TPC[18]
0x0000002a
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003645] ath: phy5: TPC[19]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003657] ath: phy5: TPC[20]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003668] ath: phy5: TPC[21]
0x00000024
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003680] ath: phy5: TPC[22]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003692] ath: phy5: TPC[23]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003703] ath: phy5: TPC[24]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003715] ath: phy5: TPC[25]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003726] ath: phy5: TPC[26]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003738] ath: phy5: TPC[27]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003749] ath: phy5: TPC[28]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003761] ath: phy5: TPC[29]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003773] ath: phy5: TPC[30]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003784] ath: phy5: TPC[31]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003796] ath: phy5: TPC[32]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003807] ath: phy5: TPC[33]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003819] ath: phy5: TPC[34]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003831] ath: phy5: TPC[35]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003845] ath: phy5: LOOP-Mode
ctlMode 0 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003861] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x01 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003877] ath: phy5: SEL-Min
ctlMode 0 pCtlMode 1 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003892] ath: phy5: LOOP-Mode
ctlMode 1 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003907] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x02 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003923] ath: phy5:
LOOP-Ctlidx 1: cfgCtl 0x12 pCtlMode 0x02 ctlIndex 0x12 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003938] ath: phy5: SEL-Min
ctlMode 1 pCtlMode 2 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003952] ath: phy5: LOOP-Mode
ctlMode 2 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003968] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003983] ath: phy5:
LOOP-Ctlidx 1: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x12 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.003999] ath: phy5:
LOOP-Ctlidx 2: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x15 chan 2432
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004014] ath: phy5: SEL-Min
ctlMode 2 pCtlMode 5 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004028] ath: phy5: TPC[00]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004040] ath: phy5: TPC[01]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004052] ath: phy5: TPC[02]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004064] ath: phy5: TPC[03]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004076] ath: phy5: TPC[04]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004088] ath: phy5: TPC[05]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004099] ath: phy5: TPC[06]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004111] ath: phy5: TPC[07]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004123] ath: phy5: TPC[08]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004135] ath: phy5: TPC[09]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004147] ath: phy5: TPC[10]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004159] ath: phy5: TPC[11]
0x00000027
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004171] ath: phy5: TPC[12]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004182] ath: phy5: TPC[13]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004194] ath: phy5: TPC[14]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004206] ath: phy5: TPC[15]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004218] ath: phy5: TPC[16]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004230] ath: phy5: TPC[17]
0x00000024
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004242] ath: phy5: TPC[18]
0x00000028
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004253] ath: phy5: TPC[19]
0x00000026
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004265] ath: phy5: TPC[20]
0x00000025
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004277] ath: phy5: TPC[21]
0x00000024
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004289] ath: phy5: TPC[22]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004301] ath: phy5: TPC[23]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004312] ath: phy5: TPC[24]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004324] ath: phy5: TPC[25]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004336] ath: phy5: TPC[26]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004348] ath: phy5: TPC[27]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004360] ath: phy5: TPC[28]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004371] ath: phy5: TPC[29]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004383] ath: phy5: TPC[30]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004395] ath: phy5: TPC[31]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004407] ath: phy5: TPC[32]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004419] ath: phy5: TPC[33]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004430] ath: phy5: TPC[34]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004442] ath: phy5: TPC[35]
0x00000000
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004468] ath: phy5: ch=0
f=2432 low=2412 10 h=2437 9 n=0 0 p=0 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004486] ath: phy5: ch=1
f=2432 low=2412 11 h=2437 13 n=0 0 p=0 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004503] ath: phy5: ch=2
f=2432 low=2412 9 h=2437 10 n=0 0 p=0 0
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.004527] ath: phy5: for
frequency=2432, calibration correction = 9 13 10
Tue Dec 22 16:59:50 2020 kern.info kernel: [29932.004677] IPv6:
ADDRCONF(NETDEV_UP): wlan5: link is not ready
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.012341] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.012360] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.012373] ath: phy5: enable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.012387] ath: phy5: AR_IMR
0x81800175 IER 0x1
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.012414] ath: phy5: Set HW RX
filter: 0x104097
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.112190] ath: phy5: New
interrupt mask 0xf0000443
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.112210] ath: phy5: new IMR
0x81800145
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.112223] ath: phy5: disable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.112240] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.112344] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.114993] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.117687] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.117699] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.117711] ath: phy5: enable
IER
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.117726] ath: phy5: AR_IMR
0x81800175 IER 0x1
Tue Dec 22 16:59:50 2020 kern.info kernel: [29932.119769] device wlan5 entered
promiscuous mode
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.124774] ath: phy5: Set HW RX
filter: 0x104097
Tue Dec 22 16:59:50 2020 daemon.notice hostapd: wlan5: interface state
UNINITIALIZED->COUNTRY_UPDATE
Tue Dec 22 16:59:50 2020 kern.debug kernel: [29932.222125] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:52 2020 kern.debug kernel: [29933.612059] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:52 2020 kern.debug kernel: [29933.614718] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:52 2020 kern.debug kernel: [29933.712061] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:53 2020 kern.debug kernel: [29934.612036] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:53 2020 kern.debug kernel: [29934.614696] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:53 2020 kern.debug kernel: [29934.712044] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:54 2020 kern.debug kernel: [29935.611942] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:54 2020 kern.debug kernel: [29935.614602] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:54 2020 kern.debug kernel: [29935.711946] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29936.611891] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29936.614550] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29936.711896] ath: phy5: AWAKE ->
FULL-SLEEP
Tue Dec 22 16:59:55 2020 daemon.err hostapd: Using interface wlan5 with hwaddr
14:3d:f2:ca:c8:14 and ssid "OpenWrt"
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.135404] ath: phy5:
FULL-SLEEP -> AWAKE
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.138063] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140755] ath: phy5: Set
channel: 2432 MHz width: 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140776] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140801] ath: phy5: Stopping
ANI
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140811] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140825] ath: phy5: Disable
MIB counters
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140926] ath: phy5: Reset to
2432 MHz, HT40: 0 fastcc: 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.140967] ath: phy5: reset MAC
via external reset
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148171] ath: phy5: TPC[00]
0x0000002c
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148186] ath: phy5: TPC[01]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148197] ath: phy5: TPC[02]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148209] ath: phy5: TPC[03]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148221] ath: phy5: TPC[04]
0x0000002e
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148232] ath: phy5: TPC[05]
0x0000002e
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148244] ath: phy5: TPC[06]
0x0000002e
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148255] ath: phy5: TPC[07]
0x0000002e
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148267] ath: phy5: TPC[08]
0x0000002d
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148278] ath: phy5: TPC[09]
0x0000002c
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148290] ath: phy5: TPC[10]
0x0000002b
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148302] ath: phy5: TPC[11]
0x00000027
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148313] ath: phy5: TPC[12]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148325] ath: phy5: TPC[13]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148336] ath: phy5: TPC[14]
0x0000002a
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148348] ath: phy5: TPC[15]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148359] ath: phy5: TPC[16]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148371] ath: phy5: TPC[17]
0x00000024
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148382] ath: phy5: TPC[18]
0x0000002a
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148394] ath: phy5: TPC[19]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148405] ath: phy5: TPC[20]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148417] ath: phy5: TPC[21]
0x00000024
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148428] ath: phy5: TPC[22]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148440] ath: phy5: TPC[23]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148451] ath: phy5: TPC[24]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148462] ath: phy5: TPC[25]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148474] ath: phy5: TPC[26]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148485] ath: phy5: TPC[27]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148496] ath: phy5: TPC[28]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148508] ath: phy5: TPC[29]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148519] ath: phy5: TPC[30]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148531] ath: phy5: TPC[31]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148542] ath: phy5: TPC[32]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148553] ath: phy5: TPC[33]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148564] ath: phy5: TPC[34]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148576] ath: phy5: TPC[35]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148590] ath: phy5: LOOP-Mode
ctlMode 0 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148606] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x01 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148623] ath: phy5: SEL-Min
ctlMode 0 pCtlMode 1 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148637] ath: phy5: LOOP-Mode
ctlMode 1 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148653] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x02 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148668] ath: phy5:
LOOP-Ctlidx 1: cfgCtl 0x12 pCtlMode 0x02 ctlIndex 0x12 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148683] ath: phy5: SEL-Min
ctlMode 1 pCtlMode 2 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148697] ath: phy5: LOOP-Mode
ctlMode 2 < 3, isHt40CtlMode 0, EXT_ADDITIVE 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148713] ath: phy5:
LOOP-Ctlidx 0: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x11 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148728] ath: phy5:
LOOP-Ctlidx 1: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x12 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148743] ath: phy5:
LOOP-Ctlidx 2: cfgCtl 0x12 pCtlMode 0x05 ctlIndex 0x15 chan 2432
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148758] ath: phy5: SEL-Min
ctlMode 2 pCtlMode 5 2xMaxEdge 60 sP 40 minCtlPwr 40
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148773] ath: phy5: TPC[00]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148784] ath: phy5: TPC[01]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148796] ath: phy5: TPC[02]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148808] ath: phy5: TPC[03]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148819] ath: phy5: TPC[04]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148831] ath: phy5: TPC[05]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148842] ath: phy5: TPC[06]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148854] ath: phy5: TPC[07]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148866] ath: phy5: TPC[08]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148877] ath: phy5: TPC[09]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148889] ath: phy5: TPC[10]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148900] ath: phy5: TPC[11]
0x00000027
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148912] ath: phy5: TPC[12]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148923] ath: phy5: TPC[13]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148935] ath: phy5: TPC[14]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148946] ath: phy5: TPC[15]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148958] ath: phy5: TPC[16]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148969] ath: phy5: TPC[17]
0x00000024
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148981] ath: phy5: TPC[18]
0x00000028
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.148992] ath: phy5: TPC[19]
0x00000026
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149004] ath: phy5: TPC[20]
0x00000025
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149015] ath: phy5: TPC[21]
0x00000024
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149027] ath: phy5: TPC[22]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149038] ath: phy5: TPC[23]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149049] ath: phy5: TPC[24]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149061] ath: phy5: TPC[25]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149072] ath: phy5: TPC[26]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149084] ath: phy5: TPC[27]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149095] ath: phy5: TPC[28]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149107] ath: phy5: TPC[29]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149118] ath: phy5: TPC[30]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149130] ath: phy5: TPC[31]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149141] ath: phy5: TPC[32]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149152] ath: phy5: TPC[33]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149164] ath: phy5: TPC[34]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149175] ath: phy5: TPC[35]
0x00000000
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149200] ath: phy5: ch=0
f=2432 low=2412 10 h=2437 9 n=0 0 p=0 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149218] ath: phy5: ch=1
f=2432 low=2412 11 h=2437 13 n=0 0 p=0 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149235] ath: phy5: ch=2
f=2432 low=2412 9 h=2437 10 n=0 0 p=0 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.149258] ath: phy5: for
frequency=2432, calibration correction = 9 13 10
Tue Dec 22 16:59:55 2020 kern.warn kernel: [29937.149348] In init_queues in
hw.c
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152826] ath: phy5: Reset TX
queue: 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152849] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152862] ath: phy5: Reset TX
queue: 1
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152880] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152891] ath: phy5: Reset TX
queue: 2
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152905] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152917] ath: phy5: Reset TX
queue: 3
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152932] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152944] ath: phy5: Reset
TXQ, inactive queue: 4
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152955] ath: phy5: Reset
TXQ, inactive queue: 5
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152966] ath: phy5: Reset
TXQ, inactive queue: 6
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152977] ath: phy5: Reset TX
queue: 7
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.152997] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153008] ath: phy5: Reset TX
queue: 8
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153030] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153041] ath: phy5: Reset TX
queue: 9
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153061] ath: phy5: tx ok
0x38f err 0x38f desc 0x0 eol 0x0 urn 0x0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153079] ath: phy5: ver
1024.0 opmode 3 chan 2432 Mhz
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153097] ath: phy5:
ah->misc_mode 0x1000000c
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.153190] ath: phy5: TS Start
0xe198000 End 0xe19c800 Virt ae198000, Size 512
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.153524] ath: phy5: Begin
init_cal by xiang
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.158034] It's QCA9550 in calib
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.172916] ERROR in CALIB
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.175668] ath: phy5: Timeout
while waiting for nf to load: AR_PHY_AGC_CONTROL=0x50d5a
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.175685] ath: phy5: Enabled
BB Watchdog timeout (25 ms)
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.175701] ath: phy5: Reset to
2432 MHz, HT40: 0 fastcc: 0 return 0
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.182154] ath: phy5: Begin
complete reset
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186399] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186412] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186424] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186436] ath: phy5: Do not
enable IER ref count -1
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186447] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186458] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186474] ath: phy5: macaddr:
14:3d:f2:ca:c8:14, bssid: 00:00:00:00:00:00, bssidmask: ff:ff:ff:ff:ff:ff
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186634] ath: phy5: Enable
MIB counters
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186655] ath: phy5: ****
ofdmlevel 3=>3, rssi=0[lo=7 hi=40]
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.186669] ath: phy5: ****
ccklevel 2=>2, rssi=0[lo=7 hi=40]
Tue Dec 22 16:59:55 2020 kern.warn kernel: [29937.186687] ******JUMP OFF
ANI******
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.190312] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.190323] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.190333] ath: phy5: enable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.190346] ath: phy5: AR_IMR
0x81800175 IER 0x1
Tue Dec 22 16:59:55 2020 kern.err kernel: [29937.190360] ath: phy5: END
complete reset
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194471] ath: phy5: New
interrupt mask 0xf0000443
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194483] ath: phy5: new IMR
0x81800145
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194495] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194604] ath: phy5: Set
channel: 2432 MHz width: 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194622] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194643] ath: phy5: Stopping
ANI
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194653] ath: phy5: disable
IER
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194666] ath: phy5: Disable
MIB counters
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194690] ath: phy5: New
interrupt mask 0xf0000473
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194701] ath: phy5: new IMR
0x81800175
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194763] ath: phy5: Reset to
2432 MHz, HT40: 0 fastcc: 0
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194777] ath: phy5:
*****NF=[0x2] READ=[0x58d5a]
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194788] ath: phy5: NF did
not complete in calibration window
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194802] ath: phy5: NF
calibrated [ctl] [chain 0] is -45
Tue Dec 22 16:59:55 2020 kern.debug kernel: [29937.194815] ath: phy5: NF[0]
(-45) > MAX (-60), correcting to MAX

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
