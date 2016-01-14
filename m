Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35925 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbcANVJD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 14 Jan 2016 16:09:03 -0500
Received: by mail-qg0-f42.google.com with SMTP id e32so404907827qgf.3
        for <backports@vger.kernel.org>; Thu, 14 Jan 2016 13:09:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <567743C9.9080700@hauke-m.de>
References: <567743C9.9080700@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 14 Jan 2016 13:08:42 -0800
Message-ID: <CAB=NE6X=9HdzwwHVXVAT+TuzpCPGX+t31+6EGA82xGCTtAr8OA@mail.gmail.com> (sfid-20160114_220906_271144_656977AA)
Subject: Re: backports-20151218 is out
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Julia Lawall <julia.lawall@lip6.fr>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Dec 20, 2015 at 4:11 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> backports-20151218 was released. This is based on linux-next next-20151218.
>
> https://www.kernel.org/pub/linux/kernel/projects/backports/2015/12/18/backports-20151218.tar.xz
>
> The source code can be found here:
> https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/
>
> All the latest releases are listed here:
> http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

Here are the stats for this release. Compared to the latest one I had
run analysis on, it seems we remain pretty constant on stats, with
SmPL grammar contributing about 54.6861% to the process.

-----------------------------------------------------------------------------
Development and Maintenance efficiency metrics:
-----------------------------------------------------------------------------
    dev-efficiency  maint-efficiency diff-wc  diffstat     clean     SmPL-Patch
          0.555556           2.33333      21         5         9
0065-ndisc_send_na-argument.cocci
              2.75                 8      64        22         8
0062-iff-no-queue.cocci
          0.666667           1.88889      17         6         9
skb_no_xmit_more.cocci
           1.16667           2.79167      67        28        24
ptp_getsettime64.cocci
          0.142857                 1      14         2        14
features_check.cocci
           1.18182           5.45455      60        13        11
0055-netdev-tstats.cocci
           1.55906           3.55118     451       198       127
0054-struct-proto_ops-sig.cocci
          0.666667           1.88889      17         6         9
no-pfmemalloc.cocci
          0.634146            1.4878      61        26        41
set_vf_rate.cocci
              3.75            10.625      85        30         8
igb_pci_error_handlers.cocci
           1.07692           4.23077      55        14        13
ethtool_cmd_mdix.cocci
          0.588235           1.23529      21        10        17    rxnfc.cocci
          0.285714           1.53571      43         8        28
get_module.cocci
          0.285714           1.53571      43         8        28
ethtool_eee.cocci
          0.714286           2.28571      16         5         7
skb_no_fcs.cocci
              0.25           1.59375      51         8        32
set_vf_spoofchk.cocci
          0.428571           2.85714      40         6        14
sriov_configure.cocci
           0.87037            2.7037     146        47        54
0031-sk_data_ready.cocci
               4.4              17.9     179        44        10
genl-const.cocci
           7.11111           49.6667     447        64         9
0019-usb_driver_lpm.cocci
          0.571429           4.14286      58         8        14
get_ts_info.cocci
           11.5333              45.4     681       173        15
0001-netlink-portid.cocci
           2.96667             16.35     981       178        60
0002-no_dmabuf.cocci
          0.444444           1.77778      32         8        18
0002-gpio-parent.cocci
          0.512821           1.89744      74        20        39
0002-group_attr_bus.cocci
          0.769231           2.79487     109        30        39
0001-group_attr_class.cocci
           1.47184            5.6484    3711       967       657 all-SmPL.cocci
-----------------------------------------------------------------------------
Patch total diff wc -l: 3075
SmPL  total diff wc -l: 3711
Total total diff wc -l: 6786
---------------------------------------
Patch diff % contribution: 45.3139
SmPL  diff % contribution: 54.6861

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
