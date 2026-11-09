Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208628;
	b=nB/P7xUAAfuvJcxd12ehaMstiGULlfVlxSSN6XR8VtIe43SqFBiPMi8GH5+dbg+y1rgE
	 aiMlbRYJ2TJvNrN0yjodlUAFa0Cj92NtD5JkhrywK+NXN4beYaZoCIUSJiU97CWUnL33N
	 m3OdRU4IkUgAzzTFP9WxGCSAdAHgJrRUmIy9exfpDXOIIB+ZO9FaO0DkxGnizsrb0Q3E7
	 MjRmiAGsMiF+cDFcM7FyNiDvkcgILzNe+fV5+GFo4Gz+s1W/Z7riHozH1daBUu4SMXaEc
	 pCgGccHvKlbGnS2LS0GD8BuFeoBeDX2JrCvhEN4l7gWFgNzWD2aC7j+0md+okFjJgjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208628;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=wGjzUkR9hUEMACizB2sADb6zF8NooksAthBvMcBbRTg=;
	b=NkNqKFdnv5ykhqg5tKCX4aoG15+Om+h7BgCFYRNs1hvKjEfNaNODjacSgjMmiLDmcRDK
	 K400ELQJ/zlBfHWjAMHlS1olVRKs0nxtCKiZAgts8NZI8bHobjGgbsviSLRCR7swLKbIN
	 X4VF2WaitCrUcGsK9Ht/8UEJeKTmg3jw1LEIxCWOD8R2IhuKPOmbAFs+SZCkWUDH+9yti
	 mzuVb6rbCrHUJBV1juEFfnlf9TtJRSHhLJtLjqyKikHOFrVTEbzC8Hedk2yUiuCYPjcIm
	 6QBXtUpqjM3o4caXx/4ObqLIzwk2SJX1TNLF7Rsa0Ojvuyz6jZOB+ZblNLNu/wzIUUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsrGu3Gw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB4606A31C
	for <backports@vger.kernel.org>; Mon,  9 Nov 2026 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsrGu3Gw
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB1141F008A1
	for <backports@vger.kernel.org>; Mon,  9 Nov 2026 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208627;
	bh=wGjzUkR9hUEMACizB2sADb6zF8NooksAthBvMcBbRTg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dsrGu3Gwgy9sl83lkXfvdKVlCgRqWJz5zBoEAIJF0RfHYTF+yWY66uWvYBzKJf9Dj
	 vspq6/ZGeNd00uLNyjTxXv5SuX4XFCugaCTIjd7nuP04XmzwPDObrnyvwgD5QgeC6s
	 pFUf0AZMrEVq9B+ADUuU/NNKdOYo92Zzd+uxlOhKf2Dx+CX+mw1AmzguaHojrYX00K
	 PthGXBcIiho8duan2wct2vBeXssnXBiXrBNEmQcjo2r3NflnQbchlTqXw6ptv1cilF
	 vZwo1exGeNFrDQWHrm7xiAshQUs5ONUEW63WCxsUBYmaj8iUdXpfuIx1+hO+hkUufD
	 1g/q/Ng408BdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2CFEC41613; Mon,  9 Nov 2026 07:17:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 222248] Good
Date: Mon, 09 Nov 2026 07:17:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Other
X-Bugzilla-Component: Spam
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johannes@sipsolutions.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: other_spam@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version assigned_to product
Message-ID: <bug-222248-58281-n2r351sEsh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222248-58281@https.bugzilla.kernel.org/>
References: <bug-222248-58281@https.bugzilla.kernel.org/>
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

Johannes Berg (johannes@sipsolutions.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Backports                   |Spam
            Version|unspecified                 |2.5
           Assignee|backports@vger.kernel.org   |other_spam@kernel-bugs.kern
                   |                            |el.org
            Product|Backports project           |Other

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
