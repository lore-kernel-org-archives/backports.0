Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52831 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab2J0OZq convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Oct 2012 10:25:46 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2866656iag.19
        for <backports@vger.kernel.org>; Sat, 27 Oct 2012 07:25:45 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 27 Oct 2012 17:25:45 +0300
Message-ID: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
Subject: Regarding compat_autoconf.h generation
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

In the nouveau DRM driver there is a CONFIG_NOUVEAU_DEBUG which has to
be an integer between 0 and 7 with the default as 3.
Currently gen-compat-autoconf.sh defines this as a string by default:

           *) # Assume string
 61                 # XXX: add better checks to make sure what was on
 62                 # the right was indeed a string
 63                 echo "#ifndef $VAR"
 64                 echo "#define $VAR \"$VALUE\""
 65                 echo "#endif /* $VAR */ "
 66                 ;;

Is it OK to modify the script to allow defining integers? Also, it
seems that there is no difference with =m and =y:

              y)
 51                 echo "#ifndef $VAR"
 52                 echo "#define $VAR 1"
 53                 echo "#endif /* $VAR */ "
 54                 ;;
 55         m)
 56                 echo "#ifndef $VAR"
 57                 echo "#define $VAR 1"
 58                 echo "#endif /* $VAR */ "
 59                 ;;

How come this doesn't break things? Both =y and =m exist in config.mk.

Thanks!

-- 
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
