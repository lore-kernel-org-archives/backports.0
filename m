Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50310 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab3E1TRE (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:17:04 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so9516833obb.16
        for <backports@vger.kernel.org>; Tue, 28 May 2013 12:17:03 -0700 (PDT)
Message-ID: <51A502AD.1060104@lwfinger.net> (sfid-20130528_211707_085177_DE2DD9E0)
Date: Tue, 28 May 2013 14:17:01 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
CC: backports@vger.kernel.org
Subject: Problem with backports git repo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Luis,

I just used 'git clone' to get a fresh copy of the repo. When I try 'make 
menuconfig', I get the following error:

finger@larrylap:~/backports/backport> make menuconfig
Generating local configuration database from kernel ...grep: .local-symbols: No 
such file or directory
  done.
Makefile.real:1: versions: No such file or directory
make[1]: *** No rule to make target `versions'.  Stop.
make: *** [menuconfig] Error 2
finger@larrylap:~/backports/backport>

I have a copy of file 'versions' from a v3.10-rc1 tarball. When I copy that to 
backport/, then that message is fixed. I think file versions needs to be added 
to the repo.

After copying the file, I now get

finger@larrylap:~/backports/backport> make menuconfig
Kconfig:27: can't open file "net/wireless/Kconfig"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2
finger@larrylap:~/backports/backport>

I have not yet figured out how to fix this one. My kernel source tree is good, 
and Kconfig matches the one in the tarball.

Thanks,

Larry
