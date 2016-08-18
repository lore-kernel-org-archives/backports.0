Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58395 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754247AbcHSAyS (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:18 -0400
Date: Thu, 18 Aug 2016 23:37:25 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, teg@jklm.no, kay@vrfy.org,
        rusty@rustcorp.com.au, akpm@linux-foundation.org,
        vegard.nossum@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        backports@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: [fengguang.wu@intel.com: [mcgrof-next:20160818-gsoc-kconf_symb]
 764ba64b670851e92a2b48540f0ad36e6ef28ca9 BUILD SUCCESS]
Message-ID: <20160818213725.GN3296@wotan.suse.de> (sfid-20160819_040342_996073_1F55D0F9)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Cristina,

No build issues found, good job. note I re-ordered your patches though to
avoid a build issue of including the new kconfig symbol file before
its generated.

Still quite a bit of ways to go but certainly in the right direction, and
these results also helps quite a bit give confidence in including the
generated kconfig symbol file you've generated.

  Luis

----- Forwarded message from kbuild test robot <fengguang.wu@intel.com> -----

Date: Fri, 19 Aug 2016 05:29:07 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [mcgrof-next:20160818-gsoc-kconf_symb] 764ba64b670851e92a2b48540f0ad36e6ef28ca9 BUILD SUCCESS

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git  20160818-gsoc-kconf_symb
764ba64b670851e92a2b48540f0ad36e6ef28ca9  Add kconf_symb as kernel module attribute

elapsed time: 80m

The following configs have been built successfully. More configs may be tested in the coming days.
configs tested: 129

i386                   randconfig-a0-08181326
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x013-201633
x86_64                 randconfig-x015-201633
x86_64                 randconfig-x012-201633
x86_64                 randconfig-x011-201633
x86_64                 randconfig-x014-201633
x86_64                 randconfig-x010-201633
x86_64                 randconfig-x017-201633
x86_64                 randconfig-x018-201633
x86_64                 randconfig-x019-201633
x86_64                 randconfig-x016-201633
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201633
i386                     randconfig-s1-201633
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-08181459
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-08181458
i386                   randconfig-i1-08181458
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x016-201633
i386                   randconfig-x014-201633
i386                   randconfig-x010-201633
i386                   randconfig-x017-201633
i386                   randconfig-x018-201633
i386                   randconfig-x012-201633
i386                   randconfig-x013-201633
i386                   randconfig-x019-201633
i386                   randconfig-x015-201633
i386                   randconfig-x011-201633
i386                   randconfig-n0-08181509
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-x002-201633
x86_64                 randconfig-x008-201633
x86_64                 randconfig-x009-201633
x86_64                 randconfig-x007-201633
x86_64                 randconfig-x003-201633
x86_64                 randconfig-x004-201633
x86_64                 randconfig-x005-201633
x86_64                 randconfig-x000-201633
x86_64                 randconfig-x006-201633
x86_64                 randconfig-x001-201633
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
i386                   randconfig-r0-08181525
i386                   randconfig-x009-201633
i386                   randconfig-x002-201633
i386                   randconfig-x006-201633
i386                   randconfig-x001-201633
i386                   randconfig-x003-201633
i386                   randconfig-x007-201633
i386                   randconfig-x008-201633
i386                   randconfig-x000-201633
i386                   randconfig-x005-201633
i386                   randconfig-x004-201633

Thanks,
Fengguang


----- End forwarded message -----

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
--
To unsubscribe from this list: send the line "unsubscribe backports" in
