Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38588 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTkd (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 15 Mar 2017 15:40:33 -0400
Received: by mail-wm0-f41.google.com with SMTP id t189so31526264wmt.1
        for <backports@vger.kernel.org>; Wed, 15 Mar 2017 12:40:32 -0700 (PDT)
Subject: Re: Errors using linux-4.4.y against kernel target v3.19
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        backports@vger.kernel.org
References: <CAAEAJfDinWQ+GdU7hJR3z79LMu8whduStXUHJqihXW0MmWBLYQ@mail.gmail.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <4f3274fd-c310-f30b-7883-2bf67125c360@broadcom.com> (sfid-20170315_204035_000931_063FE732)
Date: Wed, 15 Mar 2017 20:40:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAAEAJfDinWQ+GdU7hJR3z79LMu8whduStXUHJqihXW0MmWBLYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 15-3-2017 16:06, Ezequiel Garcia wrote:
> Hi,
> 
> I have checked out linux-4.4.y branch, and executed this:
> 
>   $ python2 gentree.py --integrate ~/repos/linux/next/
> ~/repos/linux/torvalds/  --clean --gitdebug --git-revision v4.4.53
> --verbose
> 
> My torvalds dir is reset to v3.19. It seems it goes more or less well,
> but it fails at three points:
> 
> 1) Failed to process SmPL patch
> collateral-evolutions/network/0027-genl-const/genl-const.cocci:
> 
> Failed to process SmPL patch
> collateral-evolutions/network/0027-genl-const/genl-const.cocci
> Traceback (most recent call last):
>   File "gentree.py", line 1091, in <module>
>     ret = _main()
>   File "gentree.py", line 724, in _main
>     logwrite=logwrite)
>   File "gentree.py", line 906, in process
>     apply_patches(args, "backport", source_dir, 'patches',
> bpid.target_dir, logwrite)
>   File "gentree.py", line 605, in apply_patches
>     raise Exception('SmPL patch failed')
> Exception: SmPL patch failed
> 
> Running coccinelle results in this:
> 
> [zeta@laptop ~/repos/backports]$ ./devel/pycocci
> patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
> ~/repos/linux/torvalds/backports/
> spatch --sp-file
> patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
> --in-place --recursive-includes --relax-include-path --use-coccigrep
> --timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
> -index 0
> spatch --sp-file
> patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
> --in-place --recursive-includes --relax-include-path --use-coccigrep
> --timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
> -index 1
> spatch --sp-file
> patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
> --in-place --recursive-includes --relax-include-path --use-coccigrep
> --timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
> -index 2
> spatch --sp-file
> patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
> --in-place --recursive-includes --relax-include-path --use-coccigrep
> --timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
> -index 3
> Failed to apply changes from genl-const.cocci
> Specific log output from change that failed using genl-const.cocci
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> plus: parse error:
>   File "patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci",
> line 6, column 1, charpos = 68
>   around = '__genl_const',
>   whole content = +__genl_const struct genl_multicast_group
> 
> Full log using genl-const.cocci
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> plus: parse error:
>   File "patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci",
> line 6, column 1, charpos = 68
>   around = '__genl_const',
>   whole content = +__genl_const struct genl_multicast_group
> 
> 2) The Makefile patch doesn't apply, namely:
> integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch.
> The resolution was fairly easy.
> 
> 3) The BACKPORT_BP_MODULES symbol is problematic:
> 
> scripts/kconfig/mconf Kconfig
> backports//compat/Kconfig:57: symbol 'BACKPORT_BP_MODULES' redefines
> option 'modules' already defined by symbol 'MODULES'
> make[1]: *** [scripts/kconfig/Makefile:24: menuconfig] Error 1
> make: *** [Makefile:543: menuconfig] Error 2
> 
> Any ideas on why I get all of these? Is it that v3.19 is not supported
> by the 4.4.y branch ?

I honestly don't know the current state of backports integration
feature. My use-case is creating a tarball that can be built against any
target kernel.

In your case can you try it with v4.4 kernel?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
