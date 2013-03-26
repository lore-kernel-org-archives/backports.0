Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:41425 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965367Ab3CZPXu convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 26 Mar 2013 11:23:50 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so6564058iak.18
        for <backports@vger.kernel.org>; Tue, 26 Mar 2013 08:23:49 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 26 Mar 2013 16:23:49 +0100
Message-ID: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
Subject: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

After compiling and installing the latest compat-drivers¹, when
issuing "modprobe brcmsmac" I get this error in dmesg:

brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)

What can I be missing? Now running a self-compiled kernel:

root@stt300:/home/hpc03/Escritorio/compat-drivers-2013-03-22-u# uname -r
3.9.0-rc2

¹https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/22/compat-drivers-2013-03-22-u.tar.bz2

Greetings,

-- 
Camaleón
