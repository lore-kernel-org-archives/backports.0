Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206568;
	b=Df7AVL4YysWFQNLE0oiP7rHncuDuBTQFW1dHmiQ06ioefJ3+21R3RkGb147w2R2BbCl9
	 4nQOSOnc2pBsHgPhMSuOVVL8GYH/ZeDHDG/TnfAs9Akohff6dFn6PsKDOn9piSW7FKKj6
	 JAa5NzHWIoXQ9ImRVd0iqoPD3KriAYIMJJHHhSNkHUnxosyCd77uIvpAx+CMEfiprZF+6
	 Iag6pXFI/2teYqaXrEuZj5848VcURal/7mggXVQXTsA6WR+aBkNNhS2AfKqzR9JTZwppv
	 lW6Y0wXMu5RS/EJ62DBpyjJYfJ/Qb5jCYk0ExQ80yaYRDfqfhENPtx4QjFXnUwMZslA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206568;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=tig+LHhelR1Cvo/ZyTdUPCOXOxAj2VNq4SJTbiEhl2w=;
	b=R6U1uSD2b5PpBZpTFJvY3+b6MV8WCCrSlBPsc8ytLQDlg88+YeiygFkSDrkgxvi1UiER
	 2B99Sc68Br59UG5+n9RGbam1QU7FzFzvSDaSrsuOTiHKmo48AcZi2MogkCqdVYlKufW6W
	 O23sIgBd24f6Po887xLyyuaMhzB1PxdgPKoRaHYyI63KD6ihVWGOAyw6UUrLD4WplevH0
	 m136q/9tqjlu5Gq5cKZc0anTDMRTcr2APAyxjSw6J17/WtSEQhwrWYw1PvC/UQnipPAmx
	 XTiaNl+V9adbIWFhA5RgkcXdQTP7kA5UKR69bt43hJ0QKnk0GjM6BK2Mkli6yN7ADLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1IKQ5pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C06606A31C
	for <backports@vger.kernel.org>; Mon,  9 Nov 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1IKQ5pU
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65241F0089F
	for <backports@vger.kernel.org>; Mon,  9 Nov 2026 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794206567;
	bh=tig+LHhelR1Cvo/ZyTdUPCOXOxAj2VNq4SJTbiEhl2w=;
	h=From:To:Subject:Date;
	b=m1IKQ5pU9FQgIJBkNt1mwM4ilVg3QxD73+pXAXDx68Tu8iYvb5AXZ4qgWCBJhSSNM
	 4T3hVENCbjFkgvWqrMH3Loi2v+HNvDSR9ZWy3TxJja4uAMwODTk31+tBvL9lMkX4dq
	 V6XHEHdsLCaFxogd9tFcLnAwyJwS1wb2qsRI5RSuDzdD4+bVMTTJwA9NaX1HdbDUWr
	 3EKcZGHTBKyuAqUr0aDDbK/BYK2luaOoghnfCXjSJc+xjY29sZcNp1FNtbcJBzHR0r
	 Pao9HKg+Hd1FezQRAtiVQeFoQth5wtJyYR2mBR5mssuj4Xb7p1ZPTKXtQy/Rt2StpX
	 o1YsAk0xeWK2Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA5D3C4160E; Mon,  9 Nov 2026 06:42:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 222248] New: Good
Date: Mon, 09 Nov 2026 06:42:47 +0000
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
Message-ID: <bug-222248-58281@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222248

            Bug ID: 222248
           Summary: Good
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
