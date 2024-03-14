Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D2745C2
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446380; cv=none; b=Ssw3AHbTu/msGxdz5j+KHHgkOjWlxPTi6hab+wD4co2l1EwjFjtp37OEcnZ+Z6UdiBnPrRo1XB4cLjvEOXro3+j0oKtRXESKiMmL2YSXIcuVa4duND/FW+ggEu62fuWef/05Fs+ZZqsrrcz/+QScwR7bwoeBOAsNWvltKXjND6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446380; c=relaxed/simple;
	bh=E/pjZ68mtSZCcM3QqDx0Gszvw86cX7R9EzIukbjZ4j0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BT1yvOrH4f8gODlNPePNQMZmMIVfU4n7+ObrDm/+Akg0yIhFqZ075Y1+BtxqbvanUJTmT7dpm+fU/Wwew51wnpyKKARpdRMkSXGOEEcge/2ztrBYUXqTMS84gu/lPVBZcobQ3CB16O/jgYxHVz1rHT7AFvhjB8R4Nr7vc4NcWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duh/zzem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duh/zzem"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 987A7C433C7
	for <backports@vger.kernel.org>; Thu, 14 Mar 2024 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710446380;
	bh=E/pjZ68mtSZCcM3QqDx0Gszvw86cX7R9EzIukbjZ4j0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=duh/zzemPR9O+VvGCvcYWhjyqAy+Ac/FnSDI3UX+EC5DFQ0g/LP3LL0ceytJWMNc6
	 4G3rdWXp9UsQpHoeK2D9l8jWriywxnx7zJ8h/j+ufzLVyvFSu36SGhi0vibCWz4tUE
	 H4DDmqawX4sux6ON0qJP0MBYpf4FXftL29Hd6shZ80hS4MSYwfIWqfbQIRowJHAwmZ
	 tBPg3Rc1k/HSy3xvgCYhNPkhFHwp7V4+uPCzlXa/jgRP6pBb2YMUGnAEnpeE/Rjjze
	 CkzzzO2DltuFSWAzfd2G6rWf86D1h5HgxVMToSZnwYPNquuM/Ptmfqfb0PR/dzdG0m
	 qBIe7BGadvwmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 503F8C4332E; Thu, 14 Mar 2024 19:59:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: backports@vger.kernel.org
Subject: [Bug 218599] create mesh network in backport213-5.15
Date: Thu, 14 Mar 2024 19:59:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218599-58281-DxwghRLaxa@https.bugzilla.kernel.org/>
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

--- Comment #1 from Mostafa (abdolahi68@uvic.ca) ---
This is my script to create mesh:

#!/bin/bash

# Bring down the interface
sudo ip link set wlxe8de271f11cd down
sleep 2

# Clear any existing IP addresses
sudo ip addr flush dev wlxe8de271f11cd
sleep 2

# Create the mesh interface
sudo iw dev wlxe8de271f11cd interface add mesh1 type mp
sleep 2

# Bring up the mesh interface
sudo ip link set mesh1 up
sleep 2

# Join the mesh network
sudo iw dev mesh1 mesh join mymesh
sleep 2

# Assign an IP address to the mesh interface
sudo ip addr add 192.168.1.1/24 dev mesh1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
