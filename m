Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1017C7B
	for <backports@vger.kernel.org>; Fri, 15 Mar 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496700; cv=none; b=X/FjdsE3aP198BVTthVzBfC0znet/9FR0BSzdPtrpiZr+Uwi92XZdrSO6Xq9mRxXy8E7Iwfr2Coz0EWBxUC3fjgonU9iEkRgvr5x2SUv7XOsdLY0gIYnaZaRG04T4/sUuEdS7iedP9W6IXAM2xzWjP45m9hsHXjUKoTifJRnyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496700; c=relaxed/simple;
	bh=lBNA5fXX7wv7R7x3IBa6ZJX1YczzQJQkqcH9uxwCSp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFGoNfSr67DsLS8wovP7ChI19pa6ToT1D0Q/6RNHCZe5OSbofxXmZ5K+3SHgnOpLZR1IN3JC6NkJitb6KLyNSl04Zw2b41mHHh+G+Qeeyr91S/NWX8SLSCSzqrI9g8tVYYq7l2FGCg0C88irslb6gsncuIjzp2oajQJqNONxcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq8jWzNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq8jWzNP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C651C433F1
	for <backports@vger.kernel.org>; Fri, 15 Mar 2024 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710496700;
	bh=lBNA5fXX7wv7R7x3IBa6ZJX1YczzQJQkqcH9uxwCSp8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rq8jWzNPsN8WxARNXCmKnD+Xrnxha/QRRZizy7/Em5+bXTZbMZjE9MrSJkj6YQnOd
	 sFuL2cSQMwkMEFojhIH3iv0kFolbfiQlQ1w7glAXKVlkXOyGTax6dkwM5b6rY7aKlV
	 Z7KDqgmjjGx130xuLoVi+JZQQgkysv8r+aMxG2aXXsCmlWzCvsqfpnKswtdDmjiu3d
	 eqYiTuvrMAVbKh4PZcDm7XKbWr5c3Op6jjBQVtxkJJjFZHJ1ZN3RWqIwjTau2TxyNA
	 htDGUhbq/zwfb31Yxe45PTIPm7Okw/uDE0BTgXVoOkCoT3dKGo+yxYdZdCBXNBPtC3
	 NWCe662q8jhlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4A685C4332E; Fri, 15 Mar 2024 09:58:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 218598] create mesh network in backport2
Date: Fri, 15 Mar 2024 09:58:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218598-58281-43MPeWkpwB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218598-58281@https.bugzilla.kernel.org/>
References: <bug-218598-58281@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
