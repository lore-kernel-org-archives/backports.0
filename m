Return-Path: <SRS0=XoSX=XS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED87C3A5A2
	for <backports@archiver.kernel.org>; Mon, 23 Sep 2019 02:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617A12067B
	for <backports@archiver.kernel.org>; Mon, 23 Sep 2019 02:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390768AbfIWCH1 convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfIWCH1 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 22 Sep 2019 22:07:27 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 204959] New: iwlwifi: AX200: TOF_RANGE_REQ command is called,
 crash on firmware.
Date:   Mon, 23 Sep 2019 02:07:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: chanykim@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204959-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204959

            Bug ID: 204959
           Summary: iwlwifi: AX200: TOF_RANGE_REQ command is called, crash
                    on firmware.
           Product: Backports project
           Version: unspecified
    Kernel Version: 5.1.0-050100-generic
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: chanykim@gmail.com
        Regression: No

I tried to measurement ftm_request through iw 5.3 version.
ex) iw wlan0 measurement ftm_request config_file which include <mac address>
bw=80 cf=5240 cf1=5210 asap.

At that time, iwlwifi always go to crash status.
- iwlwifi : backport-iwlwifi 4.3
- firmware : iwlwifi-cc-a0-48.ucode (firmware-version: 48.4fa0041f.0)
- kernel: 5.1.0-050100-generic

I think that there is a problem
 -> iwlwifi 0000:01:00.0: FW error in SYNC CMD TOF_RANGE_REQ_CMD
I attached dmesg, syslog, iwl.dump files.

There is a dmesg:

[72796.188587] iwlwifi 0000:01:00.0: HCMD_ACTIVE already clear for command
TOF_RANGE_REQ_CMD
[72796.188621] iwlwifi 0000:01:00.0: FW error in SYNC CMD TOF_RANGE_REQ_CMD
[72796.188640] CPU: 3 PID: 25443 Comm: iw Tainted: G        W  OE    
5.1.0-050100-generic #201905052130
[72796.188644] Hardware name: GIGABYTE GB-BSi5-6200/MKLP5AP-00, BIOS F6
05/16/2016
[72796.188646] Call Trace:
[72796.188666]  dump_stack+0x63/0x8a
[72796.188715]  iwl_trans_pcie_gen2_send_hcmd+0x43a/0x4f0 [iwlwifi]
[72796.188724]  ? wait_woken+0x80/0x80
[72796.188754]  iwl_trans_send_cmd+0x5c/0xd0 [iwlwifi]
[72796.188794]  iwl_mvm_send_cmd_status+0x38/0xc0 [iwlmvm]
[72796.188834]  iwl_mvm_ftm_start+0x3aa/0x5d0 [iwlmvm]
[72796.188852]  ? nla_validate.part.7+0x50/0x90
[72796.188862]  ? validate_nla+0xda/0x580
[72796.188872]  ? nla_validate.part.7+0x50/0x90
[72796.188881]  ? __nla_parse+0x38/0x120
[72796.188907]  iwl_mvm_start_pmsr+0x38/0x50 [iwlmvm]
[72796.188931]  ? iwl_mvm_start_pmsr+0x38/0x50 [iwlmvm]
[72796.189007]  ieee80211_start_pmsr+0x75/0x170 [mac80211]
[72796.189086]  nl80211_pmsr_start+0x49e/0x6d0 [cfg80211]
[72796.189113]  genl_family_rcv_msg+0x1d8/0x410
[72796.189123]  ? __wake_up_common_lock+0x8e/0xc0
[72796.189136]  genl_rcv_msg+0x4c/0x93
[72796.189147]  ? _cond_resched+0x19/0x30
[72796.189155]  ? genl_family_rcv_msg+0x410/0x410
[72796.189164]  netlink_rcv_skb+0x4f/0x120
[72796.189175]  genl_rcv+0x28/0x40
[72796.189184]  netlink_unicast+0x19f/0x260
[72796.189194]  netlink_sendmsg+0x20d/0x3c0
[72796.189207]  sock_sendmsg+0x3e/0x50
[72796.189216]  ___sys_sendmsg+0x295/0x2f0
[72796.189229]  ? generic_file_read_iter+0xdf/0x150
[72796.189239]  ? mem_cgroup_throttle_swaprate+0x1b/0x118
[72796.189261]  ? ext4_file_read_iter+0x54/0xf0
[72796.189278]  ? new_sync_read+0x111/0x170
[72796.189308]  __sys_sendmsg+0x5c/0xa0
[72796.189328]  __x64_sys_sendmsg+0x1f/0x30
[72796.189348]  do_syscall_64+0x5a/0x110
[72796.189367]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[72796.189385] RIP: 0033:0x7f8f11f3a490
[72796.189399] Code: 8b 15 0c ba 2b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb
cd 66 0f 1f 44 00 00 83 3d b9 12 2c 00 00 75 10 b8 2e 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 31 c3 48 83 ec 08 e8 2e cc 00 00 48 89 04 24
[72796.189411] RSP: 002b:00007ffebdfdec28 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[72796.189429] RAX: ffffffffffffffda RBX: 0000000000d55320 RCX:
00007f8f11f3a490
[72796.189443] RDX: 0000000000000000 RSI: 00007ffebdfdecb0 RDI:
0000000000000003
[72796.189456] RBP: 0000000000d54100 R08: 0000000000000001 R09:
0000000000000001
[72796.189470] R10: 00000000000000eb R11: 0000000000000246 R12:
0000000000d541d0
[72796.189482] R13: 00007ffebdfdecb0 R14: 0000000000d55230 R15:
0000000000d55320
[72796.836373] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[72796.985918] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring
[73001.079029] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[73001.079120] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[73001.079124] iwlwifi 0000:01:00.0: Status: 0x00000080, count: 6
[73001.079126] iwlwifi 0000:01:00.0: Loaded firmware version: 48.4fa0041f.0
[73001.079129] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
[73001.079131] iwlwifi 0000:01:00.0: 0x000022F0 | trm_hw_status0
[73001.079133] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[73001.079136] iwlwifi 0000:01:00.0: 0x004F8E3C | branchlink2
[73001.079138] iwlwifi 0000:01:00.0: 0x004E4FF4 | interruptlink1
[73001.079140] iwlwifi 0000:01:00.0: 0x004E4FF4 | interruptlink2
[73001.079142] iwlwifi 0000:01:00.0: 0x004F4AD2 | data1
[73001.079144] iwlwifi 0000:01:00.0: 0x00001000 | data2
[73001.079146] iwlwifi 0000:01:00.0: 0xF0000008 | data3
[73001.079148] iwlwifi 0000:01:00.0: 0x003E07A3 | beacon time
[73001.079150] iwlwifi 0000:01:00.0: 0x0C2C1461 | tsf low
[73001.079152] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[73001.079153] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[73001.079156] iwlwifi 0000:01:00.0: 0x0C2C7576 | time gp2
[73001.079157] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[73001.079160] iwlwifi 0000:01:00.0: 0x00000030 | uCode version major
[73001.079162] iwlwifi 0000:01:00.0: 0x4FA0041F | uCode version minor
[73001.079164] iwlwifi 0000:01:00.0: 0x00000340 | hw version
[73001.079166] iwlwifi 0000:01:00.0: 0x18C89000 | board version
[73001.079168] iwlwifi 0000:01:00.0: 0x802FFF02 | hcmd
[73001.079170] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[73001.079172] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[73001.079174] iwlwifi 0000:01:00.0: 0x18F84802 | isr2
[73001.079176] iwlwifi 0000:01:00.0: 0x04C1FFCC | isr3
[73001.079178] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[73001.079179] iwlwifi 0000:01:00.0: 0x001D01D2 | last cmd Id
[73001.079181] iwlwifi 0000:01:00.0: 0x004F4AD2 | wait_event
[73001.079183] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[73001.079185] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[73001.079187] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[73001.079189] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[73001.079191] iwlwifi 0000:01:00.0: 0x00000008 | lmpm_pmg_sel
[73001.079193] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[73001.079195] iwlwifi 0000:01:00.0: 0x00001868 | flow_handler
[73001.079230] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[73001.079232] iwlwifi 0000:01:00.0: Status: 0x00000080, count: 7
[73001.079233] iwlwifi 0000:01:00.0: 0x2010104C | ADVANCED_SYSASSERT
[73001.079235] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[73001.079236] iwlwifi 0000:01:00.0: 0xC008CC3C | umac branchlink2
[73001.079237] iwlwifi 0000:01:00.0: 0xC0087698 | umac interruptlink1
[73001.079238] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[73001.079239] iwlwifi 0000:01:00.0: 0xFFFF0106 | umac data1
[73001.079241] iwlwifi 0000:01:00.0: 0x00100080 | umac data2
[73001.079242] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[73001.079243] iwlwifi 0000:01:00.0: 0x00000030 | umac major
[73001.079244] iwlwifi 0000:01:00.0: 0x4FA0041F | umac minor
[73001.079245] iwlwifi 0000:01:00.0: 0x0C2C756A | frame pointer
[73001.079247] iwlwifi 0000:01:00.0: 0xC0887F3C | stack pointer
[73001.079248] iwlwifi 0000:01:00.0: 0xFFFF0106 | last host cmd
[73001.079249] iwlwifi 0000:01:00.0: 0x00020040 | isr status reg
[73001.079256] iwlwifi 0000:01:00.0: Fseq Registers:
[73001.079260] iwlwifi 0000:01:00.0: 0xE0000000 | FSEQ_ERROR_CODE
[73001.079263] iwlwifi 0000:01:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
[73001.079267] iwlwifi 0000:01:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
[73001.079271] iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[73001.079274] iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[73001.079278] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[73001.079282] iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
[73001.079285] iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
[73001.079289] iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[73001.079295] iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[73001.079301] iwlwifi 0000:01:00.0: 0x05B0905B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[73001.079306] iwlwifi 0000:01:00.0: 0x0000025B |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[73001.079441] iwlwifi 0000:01:00.0: Collecting data: trigger 2 fired.
[73001.079446] ieee80211 phy0: Hardware restart was requested
[73001.717676] iwlwifi 0000:01:00.0: Applying debug destination EXTERNAL_DRAM
[73001.867195] iwlwifi 0000:01:00.0: FW already configured (0) - re-configuring

Could you check this issue.

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
