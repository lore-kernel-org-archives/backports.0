Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A141863E
	for <backports@vger.kernel.org>; Fri, 15 Mar 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496904; cv=none; b=tByKXfPsKuPoHcu2/DT70t+8lqtFhJxLAUhMocpfmV+2gosMIZlHGLSjQ1mk28I7JZRjfgS7eIOAHsENfhuV2Cpokm6P2FVqqbIlmhhIkE1Y5T7ONyjaRq/j+kth5KEcRFEJcluAb+3ZI+7Q3+2nUtDfXD4AcaXYScQE8HFQ0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496904; c=relaxed/simple;
	bh=2EpVT3Q+ebXFUeJUJs/Ry/esYwGGcTcIMco8wizhfaQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm/vDbHCCEd43RXK3iDTYBdLpxngQPazYqPQ4ARn9fWxsmFnDuWjh4Rm9dGJK4nUMlFd+NgUpsddi9f2H+UhNpJP+TjZ8Rn2cNDFGuONnzcp8c7eNhv4DxwghN3stmHr6hZcJU8MjIlAei6QjReZage3Ryl6iaCar9BYK0fhB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtLpwt7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtLpwt7B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4010DC433F1
	for <backports@vger.kernel.org>; Fri, 15 Mar 2024 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710496904;
	bh=2EpVT3Q+ebXFUeJUJs/Ry/esYwGGcTcIMco8wizhfaQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YtLpwt7BlS/lfD7Om9bAXcF5K7cAo4J4sANM1kYNqAVHCEU/MDuaiqomD4dXocyai
	 AaCccqoNRWj4clwE0niyBhpZ8vdI13r1GDrM6JJyasPtE4I73vY71tRrhVe/HZE/mC
	 JimOBAdkwHm4k+sQ0pItYKfGy7KjUosXoG4I7xWNjTGCtntpzaxJIX0AVyJa3FGn9X
	 hi/DScEimcfhTe/6Nsmobei2kG7u3P0T5ORfb1VvkuxsDWC970yNwirm9ZWnSIcwlO
	 sh35IcRr5kY3WV2CApLUCcTXmh5QHzBJIvU7NFkSZjfn/cRS4u83eNdy91znnMaEuv
	 /Kzib1LBL7XWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33C4AC53BD0; Fri, 15 Mar 2024 10:01:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 218599] create mesh network in backport213-5.15
Date: Fri, 15 Mar 2024 10:01:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_network-wireless@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version assigned_to product
Message-ID: <bug-218599-58281-2dCiloIuFG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218599-58281@https.bugzilla.kernel.org/>
References: <bug-218599-58281@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Backports                   |network-wireless
            Version|unspecified                 |2.5
           Assignee|backports@vger.kernel.org   |drivers_network-wireless@ke
                   |                            |rnel-bugs.osdl.org
            Product|Backports project           |Drivers

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
