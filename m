Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB0CE79A8
	for <backports@archiver.kernel.org>; Tue, 19 Sep 2023 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjISRME (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRMD (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Sep 2023 13:12:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895DC6
        for <backports@vger.kernel.org>; Tue, 19 Sep 2023 10:11:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB2AEC433C8
        for <backports@vger.kernel.org>; Tue, 19 Sep 2023 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695143517;
        bh=XjdCSpgVWatO3/hfV2VkxTa0VPyX0Wrc4/GgrZ76EuI=;
        h=From:To:Subject:Date:From;
        b=HSlXBb0zNpXI+zHcO2juF70+UHDU7RHZi4uJ53scNnEqwp1p/yY+JhP0eROMrx+9z
         5pfTfEjoWcLlXxdCusEJzLNX1Q+nOJPiK2Ga3+iQ4Zty0EVpSpZ0lJX+lwLnOZNDH3
         jlu3jB5v1cAj9iwsWWZF0XS2ORokYd7Bg/Cfj5jCx6fArr4P1cWZGfKSHriNRFbkqD
         2vhzoyzjH/cwfpG2TpWtF7g0LTIsEYPkWBWGRcEHRmu8YEdlTpHqKzKj+KfGO4G3Iq
         AfGbZK9j1jlZJVmoclhEYQyHg6XriZdaX0i6KP/vHgS6OhZSs2XpOn+yZ1LdPXKdgh
         Cb1ptx4ndLDxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8779AC4332E; Tue, 19 Sep 2023 17:11:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 217925] New: Backporting ath11k QCN9074 no network interface
Date:   Tue, 19 Sep 2023 17:11:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lakshmanakumar.mohan@celestica.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217925-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217925

            Bug ID: 217925
           Summary: Backporting ath11k QCN9074 no network interface
           Product: Backports project
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: lakshmanakumar.mohan@celestica.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
