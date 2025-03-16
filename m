Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794B11185
	for <backports@vger.kernel.org>; Sun, 16 Mar 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742115115; cv=none; b=Gh0rsMzU+QVKobU2vDOwBotcJglThhBCD+xuDzjeSWGfhM3mcQ2oUsa+UAXJP0mTsbxE+LA0eBo6i3mnB6IwM9DnwvfCJVyKpvoa2FoXoBKu4Fd0m9JK6ILSaWYBzGQspUkDumOUrCg1lWNmnYOkgn13NT+J620AeL9fgL4V5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742115115; c=relaxed/simple;
	bh=Myv23NuceuZ75NyAnoGGTXwRNQXXDp58K9J0naKHLRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HfTMrnDG21naYvwVx5Z80a1us5fj9afgfdYHat0qyaF7qZgNACp+nFsATFG9kXxjjj95RJl3dYFJfqsvrjkTHnOGLU5bTZ+mJsTl+iLi4bXWh74zbb6mqXBoEmsunprIM8xv849BHeWzLm6D/i/IYXlCJNxhI4SA7IfudUDPOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7fVjrHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7fVjrHs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 733EBC4CEEA
	for <backports@vger.kernel.org>; Sun, 16 Mar 2025 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742115113;
	bh=Myv23NuceuZ75NyAnoGGTXwRNQXXDp58K9J0naKHLRI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m7fVjrHsx52grY+pRU6oGY20qz/7wKv/iBpiegkdjmnnGWjJTvogjdnZyi9iHIX66
	 NE8iFyWktDo49yIfKxzm3RAsogh3zh4ynpgedxeYZwTT6+c5OwjbLFGKaQluAO97Um
	 4BZh14MAfz0ZuNquSOjBWWiLchdkB6Qcyhc75zb6WwOWTokqqv4aBs1aBHEZgSE8Qq
	 9CdS+JtMMmaJ+Q4KEK5LIQqcofuhugRzbIBAZxd9r/jaTqjmm5q21+lqFRITcIaUB5
	 pkenRi2kmfI6nS1uYl40dVp7JtXO5IlS2E2TcB8ZfRl4Isk8TKkD+ISG8Pkf3K/O0E
	 2LofX7tnd7/iA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 542ABC53BBF; Sun, 16 Mar 2025 08:51:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 219873] Dive into Adventure: Exploring the Enduring Appeal of
 Poptropica
Date: Sun, 16 Mar 2025 08:51:53 +0000
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
Message-ID: <bug-219873-58281-Dm8Y5Y34dW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219873-58281@https.bugzilla.kernel.org/>
References: <bug-219873-58281@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219873

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
