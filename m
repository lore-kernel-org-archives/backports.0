Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B5C432C0
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33F21D7F
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSA0J convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfKSA0J (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 18 Nov 2019 19:26:09 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 205573] New: iwlwifi backport breaks realtek and ralink drivers
Date:   Tue, 19 Nov 2019 00:26:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: julyighor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-205573-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205573

            Bug ID: 205573
           Summary: iwlwifi backport breaks realtek and ralink drivers
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.9
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: julyighor@gmail.com
        Regression: No

Created attachment 285967
  --> https://bugzilla.kernel.org/attachment.cgi?id=285967&action=edit
dmesg

I do have Intel ax200 adapter.
I'm forced to use kernel 4.9 on Jetson Nano device, so I had to use iwlwifi
backport.
Once iwlwifi backport installed it breaks all my other wifi adapter drivers,
except Tp-Link one.
Please fix it or advice how to fix it.

disagrees about version of symbol __cfg80211_alloc_event_skb
disagrees about version of symbol __cfg80211_alloc_reply_skb
disagrees about version of symbol __cfg80211_send_event_skb
disagrees about version of symbol cfg80211_del_sta_sinfo
disagrees about version of symbol cfg80211_disconnected
disagrees about version of symbol cfg80211_get_bss
disagrees about version of symbol cfg80211_ibss_joined
disagrees about version of symbol cfg80211_inform_bss_frame_data
disagrees about version of symbol cfg80211_mgmt_tx_status
disagrees about version of symbol cfg80211_michael_mic_failure
disagrees about version of symbol cfg80211_new_sta
disagrees about version of symbol cfg80211_put_bss
disagrees about version of symbol cfg80211_ready_on_channel
disagrees about version of symbol cfg80211_remain_on_channel_expired
disagrees about version of symbol cfg80211_roamed
disagrees about version of symbol cfg80211_rx_mgmt
disagrees about version of symbol cfg80211_scan_done
disagrees about version of symbol cfg80211_unlink_bss
disagrees about version of symbol cfg80211_vendor_cmd_reply
disagrees about version of symbol wiphy_apply_custom_regulatory
disagrees about version of symbol wiphy_free
disagrees about version of symbol wiphy_new_nm
disagrees about version of symbol wiphy_register
disagrees about version of symbol wiphy_unregister
Unknown symbol __cfg80211_alloc_event_skb (err -22)
Unknown symbol __cfg80211_alloc_reply_skb (err -22)
Unknown symbol __cfg80211_send_event_skb (err -22)
Unknown symbol __ieee80211_get_channel (err 0)
Unknown symbol cfg80211_connect_bss (err 0)
Unknown symbol cfg80211_del_sta_sinfo (err -22)
Unknown symbol cfg80211_disconnected (err -22)
Unknown symbol cfg80211_get_bss (err -22)
Unknown symbol cfg80211_ibss_joined (err -22)
Unknown symbol cfg80211_inform_bss_frame_data (err -22)
Unknown symbol cfg80211_mgmt_tx_status (err -22)
Unknown symbol cfg80211_michael_mic_failure (err -22)
Unknown symbol cfg80211_new_sta (err -22)
Unknown symbol cfg80211_put_bss (err -22)
Unknown symbol cfg80211_ready_on_channel (err -22)
Unknown symbol cfg80211_remain_on_channel_expired (err -22)
Unknown symbol cfg80211_roamed (err -22)
Unknown symbol cfg80211_rx_mgmt (err -22)
Unknown symbol cfg80211_scan_done (err -22)
Unknown symbol cfg80211_unlink_bss (err -22)
Unknown symbol cfg80211_vendor_cmd_reply (err -22)
Unknown symbol wiphy_apply_custom_regulatory (err -22)
Unknown symbol wiphy_free (err -22)
Unknown symbol wiphy_new_nm (err -22)
Unknown symbol wiphy_register (err -22)
Unknown symbol wiphy_unregister (err -22)

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
