Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331898;
	b=rkA9AUNkFPMIK5lAYms6ZoU+0PfHaj67hV0FJRal4mZufONMovnnKsc298mKwVBBO81I
	 rCsIsWwsWfXl2GA3U9R5EwXvIAWXqb8le/dg0VnGeeSWSUDWPbrlJ4MBL14Nvrp2Fw+ZD
	 EF4lfSh6qWl8Gwlfqpia+JbDrQkSyeIo5Fwnbc2fW9QHh/MiCIXOdIl6lP8iWPEfUJXWP
	 HKZBikMS5fsr2xJihgddygiGsf+2NzKY1EnxTHsRepu2rcJXtQqLX/0s+dGpYQiFhE3+E
	 xD3WU8V2xaZn8Zjel733QWJSIJfFXvj2C8wcX5aijBRoQPdhkQ/LAmgnwT5DcpBku9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331898;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=rvXRS80Nh46S8IJz1BtSJwyetuoqAfc4FIx4NIqvklw=;
	b=tYMTcLQUkrQfdiw0U3XxQr5nVMiR7hXjrm4O9/6/48DN/r96XL2kVycTEaDeyh1HMUFv
	 mvJwrvPJMmgnIUWQWIVL9eboBLEp66NovG/dsJ8TjM+/HWmu8C6qWg05w+une/VKVzbV3
	 tyXXxew8CCnZeAFVBdIl+fGEbUm/vAfkfHv1+pJk1vDNnof6EfpEhIkmVKS1rSMICFtyZ
	 wWPOO59y9NwMFM23Lc4zLVu4oZdn3G2GdVCDUe0fIyFtzp3grWqM8L+Yj3Cq3sIMG1ryZ
	 5HFImhWiSt91Ki1V78X+HdAuYBpp2Fus3HGKQSG7QByO1zJdBy7nDvG8QfCdvODRYkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bLucYI4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38A606A31C
	for <backports@vger.kernel.org>; Tue, 10 Nov 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLucYI4/
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39D2A1F0089F
	for <backports@vger.kernel.org>; Tue, 10 Nov 2026 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331898;
	bh=rvXRS80Nh46S8IJz1BtSJwyetuoqAfc4FIx4NIqvklw=;
	h=From:To:Subject:Date;
	b=bLucYI4/l1j3v58T4UPyz3/im9pO1v7/ENCh9pVqr8z+Bz91NjrATy5IEC769A5cQ
	 6WxqMiAUzLOf0GmvXpwiu3W+3n41erCiEJANZ1bAfeF7FivO5Yi3xB87M9uk1F0tkM
	 CkF+2VAt6230Tf9dDFCJZXsOZMUkMjM3rneQhgvZoOaB7rwTHuuzV3g0FJqoAmDf5i
	 C3b8ewen/ijQdixy16EOM73Qwo9d2+euB9caPCJ5UoW91BQ4j9YHPoezN4Oydhx6Ag
	 1HfQhl0mVZcbQTQhqk5oR/XqELhT34FZcjob7cXMHX5u4I4KbhJMiJmjLf7iXO56MC
	 K+pHdLQt5Jlzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2716BC41612; Tue, 10 Nov 2026 17:31:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 222256] New: Ok
Date: Tue, 10 Nov 2026 17:31:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Wbusy48@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222256-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Post: <mailto:backports@vger.kernel.org>
List-Help: <mailto:backports+help@vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
List-Owner: <mailto:backports+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222256

            Bug ID: 222256
           Summary: Ok
           Product: Backports project
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: Wbusy48@gmail.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
