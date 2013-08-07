Return-path: <backports-owner@vger.kernel.org>
Received: from mail.lenbrook.com ([216.94.44.85]:46145 "EHLO mail.lenbrook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab3HGTz5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 15:55:57 -0400
Message-ID: <5202A643.8080404@lenbrook.com> (sfid-20130807_215559_919946_5317593F)
Date: Wed, 07 Aug 2013 15:55:47 -0400
From: Jonathan Bagg <jbagg@lenbrook.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: Issue reading kernel config
References: <1375338204-2021-8-git-send-email-sujith@msujith.org> <1375370826-1387-1-git-send-email-sujith@msujith.org> <51FA8ECD.7070401@lenbrook.com> <20130801174749.GC10904@shaftnet.org> <51FAB31F.6050207@lenbrook.com>
In-Reply-To: <51FAB31F.6050207@lenbrook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I am cross compiling backports successful using "alldefconfig".  I would 
like use menuconfig and have conf read in options from my kernel instead 
of the default.  (CONFIG_BT is not enabled in the default and I want to 
enable BT drivers in backports).  It looks like kconf/conf program is 
loading a kernel config from the root of backports called Kconfig.  When 
I replace this file with my kernel config (from 2.6.35-3) I get many....

Kconfig:1967: syntax error
Kconfig:1966: unknown statement "CONFIG_CRC_ITU_T"
Kconfig:1967: unknown statement "CONFIG_CRC32"
Kconfig:1971: syntax error
Kconfig:1970: unknown statement "CONFIG_ZLIB_INFLATE"
Kconfig:1971: unknown statement "CONFIG_ZLIB_DEFLATE"
Kconfig:1972: unknown statement "CONFIG_LZO_COMPRESS"
Kconfig:1973: unknown statement "CONFIG_LZO_DECOMPRESS"
Kconfig:1974: unknown statement "CONFIG_GENERIC_ALLOCATOR"
Kconfig:1975: unknown statement "CONFIG_HAS_IOMEM"
Kconfig:1976: unknown statement "CONFIG_HAS_IOPORT"
Kconfig:1977: unknown statement "CONFIG_HAS_DMA"
Kconfig:1978: unknown statement "CONFIG_NLATTR"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2

What is the right way to do this?  I could add CONFIG_BT=y to the 
default Kconfig file, but that seems hackish.

Jon

