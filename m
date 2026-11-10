Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332999;
	b=lzUoSKvA1ueFoOQ4CDytQfPoow0QS1J0S4ihVVXenSs5bGzhHI/Zihu4Wenu3pN2kini
	 4ck5OQHQEp0FYAWgkL1UZed7p4D9gkyoxJv2ZUHcgw3SH+IdSd6Q2d4kJ8VeoxVzfq1p/
	 pcPArGinPjDe0F9cIemiI6VCtQNPDBK7QmsHRNieXecUJGmul9HQidWL7AIZfaO78DHKo
	 2Do+PAyPuLaR2Y3Tx1gPBP31PkHE2iS+K9oH6cP8hpf15QrReonJM1bA/qULqp8SfQpV8
	 blg0S+I/brSWWGSa2bdK4XGAotoSJrVz1jEw6d3sWbBiUsFDzBcnLUq5T1yFh3EWESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332999;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=SY2cIPr3i3xbK6qcwbaXdhjbH1dExEjCUKnmWm15zi8=;
	b=Uiuqg6p3ir1H2GHdE0iyzdOHTvpKIRY81QYh7YBgm1pkHdfrOaUvSzCUSFOjX7ypTc3I
	 qUXnlqt1sJFG/W4opSonMxkuBuFoSCMCq0gZKP0UCN7ydgaSDjKdUndPPWtNNYxKT89T5
	 86DhKZZOmzdD3//o4CnHUO3b6m2c/gIfNQJyRU2ZKfS8faagTlqI/FPdDtIMh4Pt8eUeX
	 YWJIxwwKzZYYvFvCDojfH1BiiRpglLxxAI+ymQwAG16KRM2vUYHwfAGQVBFCMYcQmbdqp
	 jBlNZKceGW0AmF4oJ9BhD7s7QpiUig7rD66s9k1yqiOXN1Y4Qfqj7DY/9P7jZXwh8Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZymbSh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C859606A323
	for <backports@vger.kernel.org>; Tue, 10 Nov 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZymbSh+
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38EC11F008A2
	for <backports@vger.kernel.org>; Tue, 10 Nov 2026 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332999;
	bh=SY2cIPr3i3xbK6qcwbaXdhjbH1dExEjCUKnmWm15zi8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=iZymbSh+IWQyPNQx1WdrBMBwe1XGi461McEcfeejJWZKyR5norL3FffFyceObLU3D
	 +N5jA3O8ugTWJeZGvvWOHgVD5BHp6PlJ0ffYO7mpyFncr8sCU4aMJAd94b+qPfI6Vq
	 kdzjgnSe3N9z2xmAylU03tHZsPRO+41IYN7D4R0PuAoJTcyrVA1+Iu0wvif8fQYjZe
	 uVkOp/m+wckqDQjsyfN87LBylVkrywOVObO91hudoXsE9HDFvfcu3Nww5a+fLS0Bc5
	 Agy5mzqcvzic7ve04rHt5m2s9cN9xA52nocAeOi8EQJbxzZCVXiyDuCXjqx8V6kyN2
	 JtIdYDDWC0oYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 30830C41616; Tue, 10 Nov 2026 17:49:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 222256] Ok
Date: Tue, 10 Nov 2026 17:49:59 +0000
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
Message-ID: <bug-222256-58281-1ZAj54kRnK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222256-58281@https.bugzilla.kernel.org/>
References: <bug-222256-58281@https.bugzilla.kernel.org/>
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
