Return-path: <backports-owner@vger.kernel.org>
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:38832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeCNJol (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 14 Mar 2018 05:44:41 -0400
Date: Wed, 14 Mar 2018 04:44:26 -0500
From: Wan-Hua Chang <winnie.chang@cypress.com>
To: backports@vger.kernel.org
Cc: chln@cypress.com
Subject: Backports gentree fail with v4.12
Message-ID: <20180314094425.GA169496@aremote01.aus.cypress.com> (sfid-20180314_104444_324871_60016084)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
 
I am using backports.git and linux-stable.git to create backports
backage. When linux-stable.git is master branch, below command is done
successfully. 
 
./gentree.py --gitdebug --clean --copy-list ./copy-list.brcmfmac
--verbose ~/linux-stable ~/output/master-backports
 
But when set the linux-stable.git version to v4.12 with below command, I
found four errors during gentree and compile output package when I skip
these errors and continue. Please suggest how to fix them. Thanks!
 
./gentree.py --gitdebug --clean --git-revision v4.12 --copy-list
./copy-list.brcmfmac --verbose ~/linux-stable ~/output/v4.12-backports
 
(1)
Get original source files from git ...
...
IOError: [Errno 2] No such file or directory:
'~/stable-v4.12-backports/compat/lib-bucket_locks.c'
 
(2)
...
Applying patch 0079-netdev-destructor/brcmfmac.patch
> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> Hunk #1 succeeded at 452 (offset -10 lines).
> Hunk #2 FAILED at 651.
> 1 out of 2 hunks FAILED -- saving rejects to file
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
 
(3)
...
Applying patch lib-rhashtable.patch
> patching file compat/lib-rhashtable.c
> Hunk #2 FAILED at 226.
> 1 out of 2 hunks FAILED -- saving rejects to file
> compat/lib-rhashtable.c.rej
 
(4) 
When compile the output package(v4.12-backports), below compiling error
is seen. The reason is genl_dump_check_consistent still has three
parameters in v4.12, but it has been defined as two parameters.
 
cd ~/output/v4.12-backports
make KLIB=~/linux_4.1.15 KLIB_BUILD=~/linux_4.1.15 modules

... 
~/output/v4.12-backports/net/wireless/nl80211.c: In function
'nl80211_send_regdom':
~/output/v4.12-backports/backport-include/backport/backport.h:10:31:
error: too many arguments to function
'backport_genl_dump_check_consistent'
 #define LINUX_BACKPORT(__sym) backport_ ##__sym
                               ^
...

Thanks for the project,
Winnie

--
To unsubscribe from this list: send the line "unsubscribe backports" in
