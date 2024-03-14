Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1B74BFC
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443928; cv=none; b=t50sVE7/Km0KJmVFevjni/gYbACgEEY7LsWy8t4dOcf6T/UZCgfqzzEozOQPOGayHmRGfCCpZiviF7Pu8ddVJIhphflsClFRg4xupJwOTnBRkLxIPjUMgVuS7J/MLzsKS//ruGLAuRoJizRLwqBkaikU2Qk29E3sShODZD/p5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443928; c=relaxed/simple;
	bh=fkwWnRxsJXGI4Cw3EYfQFcBDqqrGkziADMfCYw1y9Gg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IdVMVHQhyvP6HkxD7ZaAKOuj03qYGh01I04bbtNCmCg/TZcy/YYeF6XlHjvKQt7pm5VZN5qiOwmWjn+6GGYnCDHUlb+jm9xYnK1kNRJHLxzcXHBbni+SSEbofmG3ARr6iiHVhP8z4lX0/zEDxufDw7giqM2emhn/03AQOBzEi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0abymlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0abymlm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B7C6C433C7
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710443927;
	bh=fkwWnRxsJXGI4Cw3EYfQFcBDqqrGkziADMfCYw1y9Gg=;
	h=From:To:Subject:Date:From;
	b=q0abymlmLGE2z644gh1o1qROj38eC1HfIMak/rs1/zB9Im92xMEnIT4CAJVVCMZUL
	 ND1fXEr3o7eWPFYxhivxSwbqYc/pcCH6q0LMAGNLJKyu9Zpk3Yv0k7bE5nvr4lTahe
	 S8FkzttaRYqx4a1IuKs0r7lpr6YNNeFfqkWDrLODxlA6Hxx/WY5H27Mr4F5jHtw1c3
	 t0uWG/Vr1jrjxkbPW4cCozoCri4h3oDJKKdkhq529IPGtnPoWuc4LeLXu1A7pjh+zk
	 d797omAcCEsouqQrdIMKVjkjZaz04xyizll7dvIKMhHoZ9gjfgmr6IGXCCVp5FN4sD
	 veSrID/o2Xzug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8AC7FC4332E; Thu, 14 Mar 2024 19:18:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 218598] New: create mesh network in backport2
Date: Thu, 14 Mar 2024 19:18:47 +0000
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
Message-ID: <bug-218598-58281@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218598

            Bug ID: 218598
           Summary: create mesh network in backport2
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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
