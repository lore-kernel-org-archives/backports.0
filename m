Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFD762D9
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444142; cv=none; b=JQZPEvPnnpAmyI7CF3xR6ijjp8cqn9NkAqS5pNrSENopvrR2F8JO6mF45eQEQ75fbxaS/9NtgRqMV7mEtx6euq1QNnHslvzyqxxAGU1YkVkiURhAHEXL7s64chyWnYtAXQNWDRQKYOloZS0bjUynLl0k3VBzEYHfgaxCwZNifl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444142; c=relaxed/simple;
	bh=O3tGMTDGlqaHxMmZfhjQ03/83FNrW0hRImmBt51Kxak=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b+KDEE+rTcT6RNDFC+mIi+H92mGsvXqyrfP0ot8SU5loYSVFjq+mtt2ewSS/e6JHYNPQfU3pKcHvTW6B18Gb0y2HuwE1HThQcbLOa6IZTxJkr1bM7PzuYlsCTJEaQbDo4BAQEHf5W+0gp1rRMBzijF/tHBliENbGqJgKHLEAajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npVDUpid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npVDUpid"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A22FEC433C7
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710444141;
	bh=O3tGMTDGlqaHxMmZfhjQ03/83FNrW0hRImmBt51Kxak=;
	h=From:To:Subject:Date:From;
	b=npVDUpid2+k+eQJnlrUFLVrX3Z20aCBDZpH0aLrp02oi5mN+W+zhXeaNlmlhV8nnA
	 nFhx/MWu83X+tIkfx6rZ6Br7hTX56GxoRbxxKjmTpbL3wh1iKSr+rqOGBCd9/l8xkv
	 Hd5XDdbSBDzoUS9M7o2bNBCeUmpV3vD09MpwZVbVY60aI77/EeGFpD5vxKnvDz+bUb
	 /QAx1JnOVNaH78u/D85+A9oSEOd0TRwPhKKPN/kUJ8fv8GcuHylPab35VCC8OlPVQN
	 tUCJV86/0os1HpnNobEHUbWYUzbuGU+K2f+PIvHaNzYPJJcTNyYpbedXQgpK2topwy
	 1wIm2ucPp4SxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 93677C4332E; Thu, 14 Mar 2024 19:22:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 218599] New: create mesh network in backport213-5.15
Date: Thu, 14 Mar 2024 19:22:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abdolahi68@uvic.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218599-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218599

            Bug ID: 218599
           Summary: create mesh network in backport213-5.15
           Product: Backports project
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: abdolahi68@uvic.ca
        Regression: No

Dear Sir,

I intend to create a mesh network using backport 5.13, 5.14, and 5.15, Howe=
ver,
I received the following error in all of them:
 command failed: operation not supported (-95).

Also, I have used deconfig-ath9k.

I am available if you require more information.

Thanks.
Mostafa

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
