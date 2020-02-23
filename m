Return-Path: <SRS0=W20+=4L=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_EPI,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A363C35673
	for <backports@archiver.kernel.org>; Sun, 23 Feb 2020 22:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3857420675
	for <backports@archiver.kernel.org>; Sun, 23 Feb 2020 22:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBWWYv (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 23 Feb 2020 17:24:51 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:10144 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWWYv (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Feb 2020 17:24:51 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48Qfrb3LMfzQlGb;
        Sun, 23 Feb 2020 23:24:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id OMBmXqWZhlWh; Sun, 23 Feb 2020 23:24:42 +0100 (CET)
Subject: Re: [PATCH 01/15] backports: handle RHEL 7.6 kernel
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
 <20200221095437.388a35c2cde6.Ic310f826e4d1e036eca65b4fa7d13d2da12620aa@changeid>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Autocrypt: addr=hauke@hauke-m.de; keydata=
 mQINBFtLdKcBEADFOTNUys8TnhpEdE5e1wO1vC+a62dPtuZgxYG83+9iVpsAyaSrCGGz5tmu
 BgkEMZVK9YogfMyVHFEcy0RqfO7gIYBYvFp0z32btJhjkjBm9hZ6eonjFnG9XmqDKg/aZI+u
 d9KGUh0DeaHT9FY96qdUsxIsdCodowf1eTNTJn+hdCudjLWjDf9FlBV0XKTN+ETY3pbPL2yi
 h8Uem7tC3pmU7oN7Z0OpKev5E2hLhhx+Lpcro4ikeclxdAg7g3XZWQLqfvKsjiOJsCWNXpy7
 hhru9PQE8oNFgSNzzx2tMouhmXIlzEX4xFnJghprn+8EA/sCaczhdna+LVjICHxTO36ytOv7
 L3q6xDxIkdF6vyeEtVm1OfRzfGSgKdrvxc+FRJjp3TIRPFqvYUADDPh5Az7xa1LRy3YcvKYx
 psDDKpJ8nCxNaYs6hqTbz4loHpv1hQLrPXFVpoFUApfvH/q7bb+eXVjRW1m2Ahvp7QipLEAK
 GbiV7uvALuIjnlVtfBZSxI+Xg7SBETxgK1YHxV7PhlzMdTIKY9GL0Rtl6CMir/zMFJkxTMeO
 1P8wzt+WOvpxF9TixOhUtmfv0X7ay93HWOdddAzov7eCKp4Ju1ZQj8QqROqsc/Ba87OH8cnG
 /QX9pHXpO9efHcZYIIwx1nquXnXyjJ/sMdS7jGiEOfGlp6N9IwARAQABtCFIYXVrZSBNZWhy
 dGVucyA8aGF1a2VAaGF1a2UtbS5kZT6JAlQEEwEIAD4CGwEFCwkIBwIGFQgJCgsCBBYCAwEC
 HgECF4AWIQS4+/Pwq1ZO6E9/sdOT3SBjCRC1FQUCXQTYzQUJA5qXpgAKCRCT3SBjCRC1FT6c
 D/9gD0CtAPElKwhNGzZ/KNQL39+Q4GOXDAOxyP797gegyykvaqU/p0MOKdx8F2DHJCGlrkBW
 qiEtYUARnUJOgftoTLalidwEp6eiZM9Eqin5rRR6B5NIYUIjHApxjPHSmfws5pnaBdI6NV8t
 5RpOTANIlBfP6bTBEpVGbC0BwvBFadGovcKLrnANZ4vL56zg0ykRogtD8reoNvJrNDK7XCrC
 2S0EYcGD5cXueJbpf6JRcusInYjMm/g2sRCH4cQs/VOjj3C66sNEMvvZdKExZgh/9l9RmW0X
 6y7A0SDtR3APYWGIwV0bhTS2usuOAAZQvFhc+idSG0YrHqRiOTnWxOnXkFFaOdmfk99eWaqp
 XOIgxHr6WpVromVI+wKWVNEXumLdbEAvy1vxCtpaGQpun5mRces5GB2lkZzRjm90uS9PgWB1
 IYj1ehReuj0jmkpan0XdEhwFjQ3+KfyzX7Ygt0gbzviGbtSB2s1Mh0nAdto9RdIYi3gCLQh3
 abtwk6zqsHRBp1IHjyNq60nsUSte4o1+mRBoB6I7uTkxqJPmynwpmAoaYkN2MRO8C1O09Yd4
 H3AgFGZBXpoVbph8Q7hE33Y9UrElfiDsvdj4+JVu1sdPPGFWtpjpe5LeoXzLANAbJ2T+Y68U
 gtsNFCbSKjXsRJlLIHR1yHQbq2VdUDmsUZaRbLkBDQRbS3sDAQgA4DtYzB73BUYxMaU2gbFT
 rPwXuDba+NgLpaF80PPXJXacdYoKklVyD23vTk5vw1AvMYe32Y16qgLkmr8+bS9KlLmpgNn5
 rMWzOqKr/N+m2DG7emWAg3kVjRRkJENs1aQZoUIFJFBxlVZ2OuUSYHvWujej11CLFkxQo9Ef
 a35QAEeizEGtjhjEd4OUT5iPuxxr5yQ/7IB98oTT17UBs62bDIyiG8Dhus+tG8JZAvPvh9pM
 MAgcWf+Bsu4A00r+Xyojq06pnBMa748elV1Bo48Bg0pEVncFyQ9YSEiLtdgwnq6W8E00kATG
 VpN1fafvxGRLVPfQbfrKTiTkC210L7nv2wARAQABiQI8BBgBCAAmAhsMFiEEuPvz8KtWTuhP
 f7HTk90gYwkQtRUFAl0E2QUFCQOakYIACgkQk90gYwkQtRUEfQ//SxFjktcASBIl8TZO9a5C
 cCKtwO3EvyS667D6S1bg3dFonqILXoMGJLM0z4kQa6VsVhtw2JGOIwbMnDeHtxuxLkxYvcPP
 6+GwQMkQmOsU0g8iT7EldKvjlW2ESaIVQFKAmXS8re36eQqj73Ap5lzbsZ6thw1gK9ZcMr1F
 t1Eigw02ckkY+BFetR5XGO4GaSBhRBYY7y4Xy0WuZCenY7Ev58tZr72DZJVd1Gi4YjavmCUH
 BaTv9lLPBS84C3fObxy5OvNFmKRg1NARMLqjoQeqLBwBFOUPcL9xr0//Yv5+p1SLDoEyVBhS
 0M9KSM0n9RcOiCeHVwadsmfo8sFXnfDy6tWSpGi0rUPzh9xSh5bU7htRKsGNCv1N4mUmpKro
 PLKjUsfHqytT4VGwdTDFS5E+2/ls2xi4Nj23MRh6vvocIxotJ6uNHX1kYu+1iOvsIjty700P
 3IveQoXxjQ0dfvq3Ud/Sl/5bUelft21g4Qwqp+cJGy34fSWD4PzOCEe6UgmZeKzd/w78+tWP
 vzrTXNLatbb2OpYV8gpoaeNcLlO2DHg3tRbe/3nHoU8//OciZ0Aqjs97Wq0ZaC6Cdq82QNw1
 dZixSEWAcwBw0ej3Ujdh7TUAl6tx5AcVxEAmzkgDEuoJBI4vyA1eSgMwdqpdFJW2V9Lbgjg5
 2H6vOq/ZDai29hi5AQ0EW0t7cQEIAOZqnCTnoFeTFoJU2mHdEMAhsfh7X4wTPFRy48O70y4P
 FDgingwETq8njvABMDGjN++00F8cZ45HNNB5eUKDcW9bBmxrtCK+F0yPu5fy+0M4Ntow3PyH
 MNItOWIKd//EazOKiuHarhc6f1OgErMShe/9rTmlToqxwVmfnHi1aK6wvVbTiNgGyt+2FgA6
 BQIoChkPGNQ6pgV5QlCEWvxbeyiobOSAx1dirsfogJwcTvsCU/QaTufAI9QO8dne6SKsp5z5
 8yigWPwDnOF/LvQ26eDrYHjnk7kVuBVIWjKlpiAQ00hfLU7vwQH0oncfB5HT/fL1b2461hmw
 XxeV+jEzQkkAEQEAAYkDcgQYAQgAJgIbAhYhBLj78/CrVk7oT3+x05PdIGMJELUVBQJdBNkF
 BQkDmpEUAUDAdCAEGQEIAB0WIQTLPT+4Bx34nBebC0Pxt2eFnLLrxwUCW0t7cQAKCRDxt2eF
 nLLrx3VaB/wNpvH28qjW6xuAMeXgtnOsmF9GbYjf4nkVNugsmwV7yOlE1x/p4YmkYt5bez/C
 pZ3xxiwu1vMlrXOejPcTA+EdogebBfDhOBib41W7YKb12DZos1CPyFo184+Egaqvm6e+GeXC
 tsb5iOXR6vawB0HnNeUjHyEiMeh8wkihbjIHv1Ph5mx4XKvAD454jqklOBDV1peU6mHbpka6
 UzL76m+Ig/8Bvns8nzX8NNI9ZeqYR7vactbmNYpd4dtMxof0pU13EkIiXxlmCrjM3aayemWI
 n4Sg1WAY6AqJFyR4aWRa1x7NDQivnIFoAGRVVkJLJ1h8RNIntOsXBjXBDDIIVwvvCRCT3SBj
 CRC1FZFcD/9fJY57XXQBDU9IoqTxXvr6T0XjPg7anYNTCyw3aXCW/MrHAV2/MAK9W2xbXWmM
 yvhidzdGHg80V3eJuc4XvQtrvK3HjDxh7ZpF9jUVQ39jKNYRg2lHg61gxYN3xc/J73Dw8kun
 esvZS2fHHzG1Hrj2oWv3xUbh+vvR1Kyapd5he8R07r3vmG7iCQojNYBrfVD3ZgenEmbGs9fM
 1h+n1O+YhWOgxPXWyfIMIf7WTOeY0in4CDq2ygJfWaSn6Fgd4F/UVZjRGX0JTR/TwE5S2yyr
 1Q/8vUqUO8whgCdummpC85ITZvgI8IOWMykP+HZSoqUKybsFlrX7q93ykkWNZKck7U7GFe/x
 CiaxvxyPg7vAuMLDOykqNZ1wJYzoQka1kJi6RmBFpDQUg7+/PS6lCFoEppWp7eUSSNPm8VFb
 jwa1D3MgS3+VSKOMmFWGRCY99bWnl2Zd2jfdETmBFNXA94mg2N2vI/THju79u1dR9gzpjH7R
 3jmPvpEc2WCU5uJfaVoAEqh9kI2D7NlQCG80UkXDHGmcoHBnsiEZGjzm5zYOYinjTUeoy3F0
 8aTZ+e/sj+r4VTOUB/b0jy+JPnxn23FktGIYnQ+lLsAkmcbcDwCop4V59weR2eqwBqedNRUX
 5OTP93lUIhrRIy3cZT/A5nNcUeCYRS8bCRFKrQKEn92RFg==
Message-ID: <98e5b161-1bde-e663-d08a-6f142ab40aed@hauke-m.de>
Date:   Sun, 23 Feb 2020 23:24:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200221095437.388a35c2cde6.Ic310f826e4d1e036eca65b4fa7d13d2da12620aa@changeid>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4K80s2J6DnCia6ZXxlxBm0Q8AidsBoxG7"
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4K80s2J6DnCia6ZXxlxBm0Q8AidsBoxG7
Content-Type: multipart/mixed; boundary="hVJQ4Nf5eXLcsxY6YRNRCo1xjvDWfShKD"

--hVJQ4Nf5eXLcsxY6YRNRCo1xjvDWfShKD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/21/20 9:56 AM, Johannes Berg wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> RHEL 7.6 uses kernel v3.10 with a lot of backports from newer
> kernels.  This causes compilation to break in many places when the
> backports project is used.  To solve the issue, check for RHEL release
> code 7.6 where appropriate.  This doesn't take into consideration
> lower versions of the kernel (i.e. < 7.6), because it's very difficult
> to find the information about when each feature was backported.
>=20
> type=3Dmaint
> ticket=3Dnone

Please remove these internal tags.

> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/71953
> ---
>  .../backport-include/linux/bp-devcoredump.h   |   3 +-
>  backport/backport-include/linux/etherdevice.h |   6 +-
>  backport/backport-include/linux/firmware.h    |   6 +-
>  backport/backport-include/linux/jiffies.h     |   5 +
>  backport/backport-include/linux/kernel.h      |   3 +-
>  backport/backport-include/linux/ktime.h       |   4 +-
>  backport/backport-include/linux/mm.h          |  55 ++++++
>  backport/backport-include/linux/netdevice.h   |   9 +-
>  backport/backport-include/linux/netlink.h     |   3 +-
>  backport/backport-include/linux/page_ref.h    |   3 +-
>  backport/backport-include/linux/pci.h         |   3 +-
>  backport/backport-include/linux/percpu.h      |   3 +-
>  backport/backport-include/linux/pm_runtime.h  |   3 +-
>  backport/backport-include/linux/property.h    |   3 +-
>  backport/backport-include/linux/rtnetlink.h   |   3 +-
>  backport/backport-include/linux/skbuff.h      |   6 +-
>  backport/backport-include/linux/time.h        |   6 +
>  backport/backport-include/linux/time64.h      |   3 +-
>  backport/backport-include/linux/timekeeping.h |  15 +-
>  .../backport-include/linux/u64_stats_sync.h   |   3 +-
>  backport/backport-include/linux/uuid.h        |   3 +-
>  backport/backport-include/linux/wait.h        |   3 +-
>  backport/backport-include/net/genetlink.h     |   3 +-
>  backport/backport-include/net/iw_handler.h    |   3 +-
>  backport/backport-include/net/net_namespace.h |   3 +-
>  backport/backport-include/net/netlink.h       |   6 +-
>  backport/compat/backport-3.11.c               |   2 +
>  backport/compat/backport-3.17.c               |   2 +
>  backport/compat/backport-3.19.c               |   2 +
>  backport/compat/backport-4.0.c                | 182 +++++++++++++++++-=

>  backport/compat/backport-4.2.c                |   4 +-
>  backport/compat/backport-4.4.c                |   3 +-
>  backport/compat/backport-genetlink.c          |  22 ++-
>  patches/0028-select_queue/mac80211.patch      |  10 +-
>  patches/0073-netdevice-mtu-range.cocci        |   4 +-
>  patches/0075-ndo-stats-64.cocci               |   4 +-
>  36 files changed, 351 insertions(+), 50 deletions(-)
>=20
> diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backpor=
t/backport-include/linux/bp-devcoredump.h
> index 1e4abf646d65..8826cc1fee4b 100644
> --- a/backport/backport-include/linux/bp-devcoredump.h
> +++ b/backport/backport-include/linux/bp-devcoredump.h
> @@ -7,7 +7,8 @@
>   * 4.6, outside that we can let our BPAUTO mechanism handle it.
>   */
>  #if (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
> -     LINUX_VERSION_IS_LESS(4,7,0))
> +     LINUX_VERSION_IS_LESS(4,7,0)) ||   \
> +	RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  static inline
>  void backport_dev_coredumpm(struct device *dev, struct module *owner,
>  			    void *data, size_t datalen, gfp_t gfp,
> diff --git a/backport/backport-include/linux/etherdevice.h b/backport/b=
ackport-include/linux/etherdevice.h
> index a00e66608eae..6bb7467c4ce1 100644
> --- a/backport/backport-include/linux/etherdevice.h
> +++ b/backport/backport-include/linux/etherdevice.h
> @@ -80,7 +80,8 @@ extern int eth_prepare_mac_addr_change(struct net_dev=
ice *dev, void *p);
>  extern void eth_commit_mac_addr_change(struct net_device *dev, void *p=
);
>  #endif /* < 3.9 */
> =20
> -#if LINUX_VERSION_IS_LESS(3,12,0)
> +#if LINUX_VERSION_IS_LESS(3,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /**
>   * eth_hw_addr_inherit - Copy dev_addr from another net_device
>   * @dst: pointer to net_device to copy dev_addr to
> @@ -193,7 +194,8 @@ static inline int eth_skb_pad(struct sk_buff *skb)
>  }
>  #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
> =20
> -#if LINUX_VERSION_IS_LESS(4,11,0)
> +#if LINUX_VERSION_IS_LESS(4,11,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /**
>   * ether_addr_to_u64 - Convert an Ethernet address into a u64 value.
>   * @addr: Pointer to a six-byte array containing the Ethernet address
> diff --git a/backport/backport-include/linux/firmware.h b/backport/back=
port-include/linux/firmware.h
> index b5bc16befb85..9b2c01b2d8a5 100644
> --- a/backport/backport-include/linux/firmware.h
> +++ b/backport/backport-include/linux/firmware.h
> @@ -2,10 +2,12 @@
>  #define __BACKPORT_LINUX_FIRMWARE_H
>  #include_next <linux/firmware.h>
> =20
> -#if LINUX_VERSION_IS_LESS(3,14,0)
> +#if LINUX_VERSION_IS_LESS(3,14,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define request_firmware_direct(fw, name, device) request_firmware(fw,=
 name, device)
>  #endif
> -#if LINUX_VERSION_IS_LESS(4,18,0)
> +#if LINUX_VERSION_IS_LESS(4,18,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define firmware_request_nowarn(fw, name, device) request_firmware(fw,=
 name, device)
>  #endif
> =20
> diff --git a/backport/backport-include/linux/jiffies.h b/backport/backp=
ort-include/linux/jiffies.h
> index bbadcc8cd27e..caef7db30004 100644
> --- a/backport/backport-include/linux/jiffies.h
> +++ b/backport/backport-include/linux/jiffies.h
> @@ -1,5 +1,10 @@
>  #ifndef __BACKPORT_LNIUX_JIFFIES_H
>  #define __BACKPORT_LNIUX_JIFFIES_H
> +
> +#ifndef NSEC_PER_SEC
> +#define NSEC_PER_SEC	1000000000L
> +#endif
> +
>  #include_next <linux/jiffies.h>
> =20
>  #ifndef time_is_before_jiffies
> diff --git a/backport/backport-include/linux/kernel.h b/backport/backpo=
rt-include/linux/kernel.h
> index f508166340f5..bf0889737497 100644
> --- a/backport/backport-include/linux/kernel.h
> +++ b/backport/backport-include/linux/kernel.h
> @@ -207,7 +207,8 @@ int __must_check kstrtobool_from_user(const char __=
user *s, size_t count, bool *
> =20
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,14,0)
> +#if LINUX_VERSION_IS_LESS(3,14,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
>  {
>  	return (u32)(((u64) val * ep_ro) >> 32);
> diff --git a/backport/backport-include/linux/ktime.h b/backport/backpor=
t-include/linux/ktime.h
> index 942729682c42..6ce22657b7f3 100644
> --- a/backport/backport-include/linux/ktime.h
> +++ b/backport/backport-include/linux/ktime.h
> @@ -4,7 +4,9 @@
>  #include <linux/timekeeping.h>
>  #include <linux/version.h>
> =20
> -#if  LINUX_VERSION_IS_LESS(3,17,0)
> +#if  LINUX_VERSION_IS_LESS(3,17,0) && \
> +     RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +
>  #define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
>  extern ktime_t ktime_get_raw(void);
> =20
> diff --git a/backport/backport-include/linux/mm.h b/backport/backport-i=
nclude/linux/mm.h
> index 8ff7d6a62330..8b97f98cf830 100644
> --- a/backport/backport-include/linux/mm.h
> +++ b/backport/backport-include/linux/mm.h
> @@ -12,6 +12,61 @@
>  void kvfree(const void *addr);
>  #endif /* < 3.15 */
> =20
> +#if LINUX_VERSION_IS_LESS(3,20,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
> +long get_user_pages_locked(unsigned long start, unsigned long nr_pages=
,
> +		    int write, int force, struct page **pages, int *locked);
> +#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked=
)
> +long get_user_pages_unlocked(unsigned long start, unsigned long nr_pag=
es,
> +		    int write, int force, struct page **pages);
> +#elif LINUX_VERSION_IS_LESS(4,6,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +static inline
> +long backport_get_user_pages_locked(unsigned long start, unsigned long=
 nr_pages,
> +		    int write, int force, struct page **pages, int *locked)
> +{
> +	return get_user_pages_locked(current, current->mm, start, nr_pages,
> +		    write, force, pages, locked);
> +}
> +#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
> +
> +static inline
> +long backport_get_user_pages_unlocked(unsigned long start, unsigned lo=
ng nr_pages,
> +				      int write, int force, struct page **pages)
> +{
> +	return get_user_pages_unlocked(current, current->mm, start,  nr_pages=
,
> +		    write, force, pages);
> +}
> +#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked=
)
> +#endif
> +
> +#if LINUX_VERSION_IS_LESS(4,6,0)
> +static inline
> +long backport_get_user_pages(unsigned long start, unsigned long nr_pag=
es,
> +			    int write, int force, struct page **pages,
> +			    struct vm_area_struct **vmas)
> +{
> +	return get_user_pages(current, current->mm, start,  nr_pages,
> +		    write, force, pages, vmas);
> +}
> +#define get_user_pages LINUX_BACKPORT(get_user_pages)
> +#endif
> +
> +#ifndef FOLL_TRIED
> +#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> +#endif
> +
> +#if LINUX_VERSION_IS_LESS(4,1,9) && \
> +     LINUX_VERSION_IS_GEQ(3,6,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +#define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
> +static inline bool page_is_pfmemalloc(struct page *page)
> +{
> +	return page->pfmemalloc;
> +}
> +#endif /* < 4.2 */
> +

This block caused problems and is not needed any more, I removed it here:=

https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/c=
ommit/?id=3D221755b9531d8b3395058a7a6f8a4e3b49783561

Please check if you really need it.

>  #if LINUX_VERSION_IS_LESS(4,12,0)
>  #define kvmalloc LINUX_BACKPORT(kvmalloc)
>  static inline void *kvmalloc(size_t size, gfp_t flags)
> diff --git a/backport/backport-include/linux/netdevice.h b/backport/bac=
kport-include/linux/netdevice.h
> index 76b57e4df067..dd8a103d034d 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -21,7 +21,8 @@ struct inet6_dev;
>   */
>  #include <linux/hardirq.h>
> =20
> -#if LINUX_VERSION_IS_LESS(3,14,0)
> +#if LINUX_VERSION_IS_LESS(3,14,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /*
>   * Backports note: if in-kernel support is provided we could then just=

>   * take the kernel's implementation of __dev_kfree_skb_irq() as it req=
uires
> @@ -237,7 +238,8 @@ static inline void backport_unregister_netdevice_ma=
ny(struct list_head *head)
>  #define napi_alloc_frag(fragsz) netdev_alloc_frag(fragsz)
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,19,0)
> +#if LINUX_VERSION_IS_LESS(3,19,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /* RSS keys are 40 or 52 bytes long */
>  #define NETDEV_RSS_KEY_LEN 52
>  #define netdev_rss_key_fill LINUX_BACKPORT(netdev_rss_key_fill)
> @@ -331,7 +333,8 @@ static inline void netif_tx_napi_add(struct net_dev=
ice *dev,
>  #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(4,7,0)
> +#if LINUX_VERSION_IS_LESS(4,7,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define netif_trans_update LINUX_BACKPORT(netif_trans_update)
>  static inline void netif_trans_update(struct net_device *dev)
>  {
> diff --git a/backport/backport-include/linux/netlink.h b/backport/backp=
ort-include/linux/netlink.h
> index 0fb8e0f39b7a..f5ff9bc18598 100644
> --- a/backport/backport-include/linux/netlink.h
> +++ b/backport/backport-include/linux/netlink.h
> @@ -3,7 +3,8 @@
>  #include_next <linux/netlink.h>
>  #include <linux/version.h>
> =20
> -#if LINUX_VERSION_IS_LESS(4,14,0)
> +#if LINUX_VERSION_IS_LESS(4,14,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  struct nla_bitfield32 {
>  	__u32 value;
>  	__u32 selector;
> diff --git a/backport/backport-include/linux/page_ref.h b/backport/back=
port-include/linux/page_ref.h
> index e45734ecd96e..9c62ff2f72bb 100644
> --- a/backport/backport-include/linux/page_ref.h
> +++ b/backport/backport-include/linux/page_ref.h
> @@ -1,7 +1,8 @@
>  #ifndef __BP_PAGE_REF_H
>  #define __BP_PAGE_REF_H
>  #include <linux/version.h>
> -#if LINUX_VERSION_IS_GEQ(4,6,0)
> +#if LINUX_VERSION_IS_GEQ(4,6,0) || \
> +	RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  #include_next <linux/page_ref.h>
>  #else
>  static inline void page_ref_inc(struct page *page)
> diff --git a/backport/backport-include/linux/pci.h b/backport/backport-=
include/linux/pci.h
> index 1cc5f28192bb..377e9f99e5a7 100644
> --- a/backport/backport-include/linux/pci.h
> +++ b/backport/backport-include/linux/pci.h
> @@ -210,7 +210,8 @@ static inline int pci_enable_msix_exact(struct pci_=
dev *dev,
>  #if LINUX_VERSION_IS_LESS(4,9,0) &&			\
>  	!LINUX_VERSION_IN_RANGE(3,12,69, 3,13,0) &&	\
>  	!LINUX_VERSION_IN_RANGE(4,4,37, 4,5,0) &&	\
> -	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0)
> +	!LINUX_VERSION_IN_RANGE(4,8,13, 4,9,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> =20
>  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)=

>  {
> diff --git a/backport/backport-include/linux/percpu.h b/backport/backpo=
rt-include/linux/percpu.h
> index 10be03cba795..16f3656f1ad9 100644
> --- a/backport/backport-include/linux/percpu.h
> +++ b/backport/backport-include/linux/percpu.h
> @@ -5,7 +5,8 @@
>  #define __BACKPORT_PERCPU_H
>  #include_next <linux/percpu.h>
> =20
> -#if LINUX_VERSION_IS_LESS(3,18,0)
> +#if LINUX_VERSION_IS_LESS(3,18,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline void __percpu *__alloc_gfp_warn(void)
>  {
>  	WARN(1, "Cannot backport alloc_percpu_gfp");
> diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/ba=
ckport-include/linux/pm_runtime.h
> index e16cd30bf5c7..0e77292f53ea 100644
> --- a/backport/backport-include/linux/pm_runtime.h
> +++ b/backport/backport-include/linux/pm_runtime.h
> @@ -16,7 +16,8 @@ static inline bool pm_runtime_active(struct device *d=
ev) { return true; }
> =20
>  #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
> =20
> -#if LINUX_VERSION_IS_LESS(3,15,0)
> +#if LINUX_VERSION_IS_LESS(3,15,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline int pm_runtime_force_suspend(struct device *dev)
>  {
>  #ifdef CONFIG_PM
> diff --git a/backport/backport-include/linux/property.h b/backport/back=
port-include/linux/property.h
> index a0d7bed12af3..cef521c07863 100644
> --- a/backport/backport-include/linux/property.h
> +++ b/backport/backport-include/linux/property.h
> @@ -1,7 +1,8 @@
>  #ifndef __BACKPORT_LINUX_PROPERTY_H_
>  #define __BACKPORT_LINUX_PROPERTY_H_
>  #include <linux/version.h>
> -#if LINUX_VERSION_IS_GEQ(3,18,17)
> +#if LINUX_VERSION_IS_GEQ(3,18,17) || \
> +	RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  #include_next <linux/property.h>
>  #endif
> =20
> diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/bac=
kport-include/linux/rtnetlink.h
> index 59beffa8316a..5b9eea64b7e6 100644
> --- a/backport/backport-include/linux/rtnetlink.h
> +++ b/backport/backport-include/linux/rtnetlink.h
> @@ -19,7 +19,8 @@
>  #endif
> =20
>  #if LINUX_VERSION_IS_LESS(3,13,0) &&		\
> -	!defined(CONFIG_PROVE_LOCKING)
> +	!defined(CONFIG_PROVE_LOCKING) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline bool lockdep_rtnl_is_held(void)
>  {
>  	return true;
> diff --git a/backport/backport-include/linux/skbuff.h b/backport/backpo=
rt-include/linux/skbuff.h
> index 42b048ad14bf..8af34146432e 100644
> --- a/backport/backport-include/linux/skbuff.h
> +++ b/backport/backport-include/linux/skbuff.h
> @@ -300,7 +300,8 @@ int skb_ensure_writable(struct sk_buff *skb, int wr=
ite_len);
> =20
>  #endif /* LINUX_VERSION_IS_LESS(3,19,0) */
> =20
> -#if LINUX_VERSION_IS_LESS(4,2,0)
> +#if LINUX_VERSION_IS_LESS(4,2,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline void skb_free_frag(void *data)
>  {
>  	put_page(virt_to_head_page(data));
> @@ -329,7 +330,8 @@ static inline u32 skb_get_hash_perturb(struct sk_bu=
ff *skb, u32 key)
>  #endif /* LINUX_VERSION_IS_LESS(3,3,0) */
>  #endif /* LINUX_VERSION_IS_LESS(4,2,0) */
> =20
> -#if LINUX_VERSION_IS_LESS(4,13,0)
> +#if LINUX_VERSION_IS_LESS(4,13,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline void *backport_skb_put(struct sk_buff *skb, unsigned int=
 len)
>  {
>  	return skb_put(skb, len);
> diff --git a/backport/backport-include/linux/time.h b/backport/backport=
-include/linux/time.h
> index 3191047dcfbc..c3a902ebd268 100644
> --- a/backport/backport-include/linux/time.h
> +++ b/backport/backport-include/linux/time.h
> @@ -1,5 +1,11 @@
>  #ifndef __BACKPORT_LINUX_TIME_H
>  #define __BACKPORT_LINUX_TIME_H
> +
> +#if RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
> +#include_next <linux/time64.h>
> +#include <uapi/linux/time.h>
> +#endif
> +

Something is strange with the time header file handling.

>  #include_next <linux/time.h>
> =20
>  #include <linux/time64.h>
> diff --git a/backport/backport-include/linux/time64.h b/backport/backpo=
rt-include/linux/time64.h
> index 49805da9dfce..62a7a1947f48 100644
> --- a/backport/backport-include/linux/time64.h
> +++ b/backport/backport-include/linux/time64.h
> @@ -6,7 +6,8 @@
>  #include <linux/time.h>
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define timespec64_equal		timespec_equal
>  #define timespec64_compare		timespec_compare
>  #define set_normalized_timespec64	set_normalized_timespec
> diff --git a/backport/backport-include/linux/timekeeping.h b/backport/b=
ackport-include/linux/timekeeping.h
> index 25ceaf3eec77..3f4a211721b2 100644
> --- a/backport/backport-include/linux/timekeeping.h
> +++ b/backport/backport-include/linux/timekeeping.h
> @@ -3,11 +3,13 @@
>  #include <linux/version.h>
>  #include <linux/types.h>
> =20
> -#if LINUX_VERSION_IS_GEQ(3,17,0)
> +#if LINUX_VERSION_IS_GEQ(3,17,0) || \
> +	RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  #include_next <linux/timekeeping.h>
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
>  extern ktime_t ktime_get(void);
>  #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
> @@ -54,14 +56,16 @@ static inline time64_t ktime_get_real_seconds(void)=

>  }
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline void ktime_get_ts64(struct timespec64 *ts)
>  {
>  	ktime_get_ts(ts);
>  }
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /* This was introduced in 4.15, but we only need it in the
>   * ktime_get_raw_ts64 backport() for < 3.17.
>   */
> @@ -83,7 +87,8 @@ static inline struct timespec64 timespec_to_timespec6=
4(const struct timespec ts)
>  #endif
>  #endif /* < 3.17 */
> =20
> -#if LINUX_VERSION_IS_LESS(4,18,0)
> +#if LINUX_VERSION_IS_LESS(4,18,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
>  static inline void ktime_get_raw_ts64(struct timespec64 *ts)
>  {
> diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backpor=
t/backport-include/linux/u64_stats_sync.h
> index 251373a74139..33278d509863 100644
> --- a/backport/backport-include/linux/u64_stats_sync.h
> +++ b/backport/backport-include/linux/u64_stats_sync.h
> @@ -115,7 +115,8 @@ static inline bool u64_stats_fetch_retry(const stru=
ct u64_stats_sync *syncp,
>  #endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
> =20
>  #if LINUX_VERSION_IS_LESS(3,15,0) && \
> -    !(LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30)
> +    !(LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_=
stats_sync *syncp)
>  {
>  #if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
> diff --git a/backport/backport-include/linux/uuid.h b/backport/backport=
-include/linux/uuid.h
> index bc6fbe17cb08..69f7d8c8b733 100644
> --- a/backport/backport-include/linux/uuid.h
> +++ b/backport/backport-include/linux/uuid.h
> @@ -11,7 +11,8 @@
>  #define	UUID_STRING_LEN		36
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(4,13,0)
> +#if LINUX_VERSION_IS_LESS(4,13,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define guid_t uuid_le
>  #define uuid_t uuid_be
> =20
> diff --git a/backport/backport-include/linux/wait.h b/backport/backport=
-include/linux/wait.h
> index 15a674cfe019..fc5b52c4d457 100644
> --- a/backport/backport-include/linux/wait.h
> +++ b/backport/backport-include/linux/wait.h
> @@ -2,7 +2,8 @@
>  #define __BACKPORT_LINUX_WAIT_H
>  #include_next <linux/wait.h>
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  extern int bit_wait(void *);
>  extern int bit_wait_io(void *);
> =20
> diff --git a/backport/backport-include/net/genetlink.h b/backport/backp=
ort-include/net/genetlink.h
> index 747b6dac2df5..e6b78e02afe3 100644
> --- a/backport/backport-include/net/genetlink.h
> +++ b/backport/backport-include/net/genetlink.h
> @@ -27,7 +27,8 @@ static inline int genl_err_attr(struct genl_info *inf=
o, int err,
>  /* this is for patches we apply */
>  static inline struct netlink_ext_ack *genl_info_extack(struct genl_inf=
o *info)
>  {
> -#if LINUX_VERSION_IS_GEQ(4,12,0)
> +#if LINUX_VERSION_IS_GEQ(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  	return info->extack;
>  #else
>  	return info->userhdr;
> diff --git a/backport/backport-include/net/iw_handler.h b/backport/back=
port-include/net/iw_handler.h
> index 84d63b30953e..f908446661c4 100644
> --- a/backport/backport-include/net/iw_handler.h
> +++ b/backport/backport-include/net/iw_handler.h
> @@ -2,7 +2,8 @@
>  #define __BACKPORT_IW_HANDLER_H
>  #include_next <net/iw_handler.h>
> =20
> -#if LINUX_VERSION_IS_LESS(4,1,0)
> +#if LINUX_VERSION_IS_LESS(4,1,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline char *
>  iwe_stream_add_event_check(struct iw_request_info *info, char *stream,=

>  			   char *ends, struct iw_event *iwe, int event_len)
> diff --git a/backport/backport-include/net/net_namespace.h b/backport/b=
ackport-include/net/net_namespace.h
> index 1e84297c9476..e8438cbcd4df 100644
> --- a/backport/backport-include/net/net_namespace.h
> +++ b/backport/backport-include/net/net_namespace.h
> @@ -14,7 +14,8 @@ static inline struct net *get_net_ns_by_fd(int fd)
>  }
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(4,1,0)
> +#if LINUX_VERSION_IS_LESS(4,1,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  typedef struct {
>  #ifdef CONFIG_NET_NS
>  	struct net *net;
> diff --git a/backport/backport-include/net/netlink.h b/backport/backpor=
t-include/net/netlink.h
> index b2045e44737a..bc24adfb4d63 100644
> --- a/backport/backport-include/net/netlink.h
> +++ b/backport/backport-include/net/netlink.h
> @@ -557,7 +557,8 @@ static inline int nla_put_be64(struct sk_buff *skb,=
 int attrtype, __be64 value)
>  #define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
>  #endif
> =20
> -#if LINUX_VERSION_IS_LESS(4,1,0)
> +#if LINUX_VERSION_IS_LESS(4,1,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  #define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
>  static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
>  				  __be32 addr)
> @@ -706,7 +707,8 @@ static inline int nla_put_s64(struct sk_buff *skb, =
int attrtype, s64 value,
>  }
>  #endif /* < 4.7 */
> =20
> -#if LINUX_VERSION_IS_LESS(4,10,0)
> +#if LINUX_VERSION_IS_LESS(4,10,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  /**
>   * nla_memdup - duplicate attribute memory (kmemdup)
>   * @src: netlink attribute to duplicate from
> diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport=
-3.11.c
> index 7f9ff3419344..a3d4ea54e3eb 100644
> --- a/backport/compat/backport-3.11.c
> +++ b/backport/compat/backport-3.11.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static bool sg_miter_get_next_page(struct sg_mapping_iter *miter)
>  {
>  	if (!miter->__remaining) {
> @@ -122,3 +123,4 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsi=
gned int nents, void *buf,
>  	return offset;
>  }
>  EXPORT_SYMBOL_GPL(sg_copy_buffer);
> +#endif
> diff --git a/backport/compat/backport-3.17.c b/backport/compat/backport=
-3.17.c
> index bf6027cbeb5e..adabec1b5367 100644
> --- a/backport/compat/backport-3.17.c
> +++ b/backport/compat/backport-3.17.c
> @@ -15,6 +15,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/moduleparam.h>
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  int bit_wait(void *word)
>  {
>  	schedule();
> @@ -28,6 +29,7 @@ int bit_wait_io(void *word)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bit_wait_io);
> +#endif
> =20
>  /**
>   * ktime_get_raw - Returns the raw monotonic time in ktime_t format
> diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport=
-3.19.c
> index 019644dfab42..ec44130e1dbd 100644
> --- a/backport/compat/backport-3.19.c
> +++ b/backport/compat/backport-3.19.c
> @@ -83,6 +83,7 @@ int woken_wake_function(wait_queue_t *wait, unsigned =
mode, int sync, void *key)
>  EXPORT_SYMBOL(woken_wake_function);
>  #endif
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
> =20
>  void netdev_rss_key_fill(void *buffer, size_t len)
> @@ -96,6 +97,7 @@ void netdev_rss_key_fill(void *buffer, size_t len)
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(netdev_rss_key_fill);
> +#endif
> =20
>  #if defined(CONFIG_DEBUG_FS)
>  struct debugfs_devm_entry {
> diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-=
4.0.c
> index fbe0ddbc3bdd..d6e22d37a91e 100644
> --- a/backport/compat/backport-4.0.c
> +++ b/backport/compat/backport-4.0.c
> @@ -18,6 +18,185 @@
>  #include <linux/ftrace_event.h>
>  #include <asm/unaligned.h>
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> + static __always_inline long __get_user_pages_locked(struct task_struc=
t *tsk,
> +						struct mm_struct *mm,
> +						unsigned long start,
> +						unsigned long nr_pages,
> +						int write, int force,
> +						struct page **pages,
> +						struct vm_area_struct **vmas,
> +						int *locked, bool notify_drop,
> +						unsigned int flags)
> +{
> +	long ret, pages_done;
> +	bool lock_dropped;
> +
> +	if (locked) {
> +		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
> +		BUG_ON(vmas);
> +		/* check caller initialized locked */
> +		BUG_ON(*locked !=3D 1);
> +	}
> +
> +	if (pages)
> +		flags |=3D FOLL_GET;
> +	if (write)
> +		flags |=3D FOLL_WRITE;
> +	if (force)
> +		flags |=3D FOLL_FORCE;
> +
> +	pages_done =3D 0;
> +	lock_dropped =3D false;
> +	for (;;) {
> +		ret =3D __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
> +				       vmas, locked);
> +		if (!locked)
> +			/* VM_FAULT_RETRY couldn't trigger, bypass */
> +			return ret;
> +
> +		/* VM_FAULT_RETRY cannot return errors */
> +		if (!*locked) {
> +			BUG_ON(ret < 0);
> +			BUG_ON(ret >=3D nr_pages);
> +		}
> +
> +		if (!pages)
> +			/* If it's a prefault don't insist harder */
> +			return ret;
> +
> +		if (ret > 0) {
> +			nr_pages -=3D ret;
> +			pages_done +=3D ret;
> +			if (!nr_pages)
> +				break;
> +		}
> +		if (*locked) {
> +			/* VM_FAULT_RETRY didn't trigger */
> +			if (!pages_done)
> +				pages_done =3D ret;
> +			break;
> +		}
> +		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
> +		pages +=3D ret;
> +		start +=3D ret << PAGE_SHIFT;
> +
> +		/*
> +		 * Repeat on the address that fired VM_FAULT_RETRY
> +		 * without FAULT_FLAG_ALLOW_RETRY but with
> +		 * FAULT_FLAG_TRIED.
> +		 */
> +		*locked =3D 1;
> +		lock_dropped =3D true;
> +		down_read(&mm->mmap_sem);
> +		ret =3D __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> +				       pages, NULL, NULL);
> +		if (ret !=3D 1) {
> +			BUG_ON(ret > 1);
> +			if (!pages_done)
> +				pages_done =3D ret;
> +			break;
> +		}
> +		nr_pages--;
> +		pages_done++;
> +		if (!nr_pages)
> +			break;
> +		pages++;
> +		start +=3D PAGE_SIZE;
> +	}
> +	if (notify_drop && lock_dropped && *locked) {
> +		/*
> +		 * We must let the caller know we temporarily dropped the lock
> +		 * and so the critical section protected by it was lost.
> +		 */
> +		up_read(&mm->mmap_sem);
> +		*locked =3D 0;
> +	}
> +	return pages_done;
> +}
> +
> +/*
> + * We can leverage the VM_FAULT_RETRY functionality in the page fault
> + * paths better by using either get_user_pages_locked() or
> + * get_user_pages_unlocked().
> + *
> + * get_user_pages_locked() is suitable to replace the form:
> + *
> + *      down_read(&mm->mmap_sem);
> + *      do_something()
> + *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      up_read(&mm->mmap_sem);
> + *
> + *  to:
> + *
> + *      int locked =3D 1;
> + *      down_read(&mm->mmap_sem);
> + *      do_something()
> + *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
> + *      if (locked)
> + *          up_read(&mm->mmap_sem);
> + */
> +long get_user_pages_locked(unsigned long start, unsigned long nr_pages=
,
> +			   int write, int force, struct page **pages,
> +			   int *locked)
> +{
> +	return __get_user_pages_locked(current, current->mm, start, nr_pages,=

> +				       write, force, pages, NULL, locked, true,
> +				       FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL_GPL(get_user_pages_locked);
> +
> +/*
> + * Same as get_user_pages_unlocked(...., FOLL_TOUCH) but it allows to
> + * pass additional gup_flags as last parameter (like FOLL_HWPOISON).
> + *
> + * NOTE: here FOLL_TOUCH is not set implicitly and must be set by the
> + * caller if required (just like with __get_user_pages). "FOLL_GET",
> + * "FOLL_WRITE" and "FOLL_FORCE" are set implicitly as needed
> + * according to the parameters "pages", "write", "force"
> + * respectively.
> + */
> +static __always_inline long __get_user_pages_unlocked(struct task_stru=
ct *tsk, struct mm_struct *mm,
> +					       unsigned long start, unsigned long nr_pages,
> +					       int write, int force, struct page **pages,
> +					       unsigned int gup_flags)
> +{
> +	long ret;
> +	int locked =3D 1;
> +	down_read(&mm->mmap_sem);
> +	ret =3D __get_user_pages_locked(tsk, mm, start, nr_pages, write, forc=
e,
> +				      pages, NULL, &locked, false, gup_flags);
> +	if (locked)
> +		up_read(&mm->mmap_sem);
> +	return ret;
> +}
> +
> +/*
> + * get_user_pages_unlocked() is suitable to replace the form:
> + *
> + *      down_read(&mm->mmap_sem);
> + *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      up_read(&mm->mmap_sem);
> + *
> + *  with:
> + *
> + *      get_user_pages_unlocked(tsk, mm, ..., pages);
> + *
> + * It is functionally equivalent to get_user_pages_fast so
> + * get_user_pages_fast should be used instead, if the two parameters
> + * "tsk" and "mm" are respectively equal to current and current->mm,
> + * or if "force" shall be set to 1 (get_user_pages_fast misses the
> + * "force" parameter).
> + */
> +long get_user_pages_unlocked(unsigned long start, unsigned long nr_pag=
es,
> +			     int write, int force, struct page **pages)
> +{
> +	return __get_user_pages_unlocked(current, current->mm, start, nr_page=
s,
> +					 write, force, pages, FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
> +#endif
> +

Please check if this is needed at all.

>  /**
>   * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memor=
y
>   * @buf: data blob to dump
> @@ -146,7 +325,8 @@ overflow1:
>  }
>  EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
> =20
> -#if LINUX_VERSION_IS_LESS(3,17,0)
> +#if LINUX_VERSION_IS_LESS(3,17,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static inline unsigned char *
>  trace_seq_buffer_ptr(struct trace_seq *s)
>  {
> diff --git a/backport/compat/backport-4.2.c b/backport/compat/backport-=
4.2.c
> index b275d349f7eb..85c7d594f05f 100644
> --- a/backport/compat/backport-4.2.c
> +++ b/backport/compat/backport-4.2.c
> @@ -11,7 +11,8 @@
>  #include <crypto/scatterwalk.h>
>  #include <crypto/aead.h>
> =20
> -static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],=

> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> + static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2]=
,

Why  did you add a space?

>  					    struct scatterlist *src,
>  					    unsigned int len)
>  {
> @@ -32,6 +33,7 @@ static struct scatterlist *scatterwalk_ffwd(struct sc=
atterlist dst[2],
> =20
>  	return dst;
>  }
> +#endif
> =20
>  struct aead_old_request {
>  	struct scatterlist srcbuf[2];
> diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-=
4.4.c
> index 7966e94928e7..1782a03486fb 100644
> --- a/backport/compat/backport-4.4.c
> +++ b/backport/compat/backport-4.4.c
> @@ -21,7 +21,8 @@
>  #include <asm/unaligned.h>
> =20
>  #ifdef CONFIG_DEBUG_FS
> -#if LINUX_VERSION_IS_LESS(4,3,0)
> +#if LINUX_VERSION_IS_LESS(4,3,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static ssize_t debugfs_read_file_bool(struct file *file, char __user *=
user_buf,
>  				      size_t count, loff_t *ppos)
>  {
> diff --git a/backport/compat/backport-genetlink.c b/backport/compat/bac=
kport-genetlink.c
> index 4707858990e2..c7f350f6f33e 100644
> --- a/backport/compat/backport-genetlink.c
> +++ b/backport/compat/backport-genetlink.c
> @@ -17,6 +17,7 @@
>  #include <net/netlink.h>
>  #include <net/sock.h>
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  static const struct genl_family *find_family_real_ops(__genl_const str=
uct genl_ops **ops)
>  {
>  	const struct genl_family *family;
> @@ -33,7 +34,8 @@ static const struct genl_family *find_family_real_ops=
(__genl_const struct genl_o
>  	return family;
>  }
> =20
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  enum nlmsgerr_attrs {
>  	NLMSGERR_ATTR_UNUSED,
>  	NLMSGERR_ATTR_MSG,
> @@ -154,7 +156,8 @@ static int backport_pre_doit(__genl_const struct ge=
nl_ops *ops,
>  {
>  	const struct genl_family *family =3D find_family_real_ops(&ops);
>  	int err;
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  	struct netlink_ext_ack *extack =3D kzalloc(sizeof(*extack), GFP_KERNE=
L);
> =20
>  	if (!extack)
> @@ -179,7 +182,8 @@ static int backport_pre_doit(__genl_const struct ge=
nl_ops *ops,
>  	if (!err && family->pre_doit)
>  		err =3D family->pre_doit(ops, skb, info);
> =20
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  	if (err) {
>  		/* signal to do nothing */
>  		extack->__bp_doit =3D NULL;
> @@ -204,7 +208,8 @@ static void backport_post_doit(__genl_const struct =
genl_ops *ops,
>  {
>  	const struct genl_family *family =3D find_family_real_ops(&ops);
> =20
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  	if (genl_info_extack(info)->__bp_doit)
>  #else
>  	if (1)
> @@ -212,11 +217,13 @@ static void backport_post_doit(__genl_const struc=
t genl_ops *ops,
>  		if (family->post_doit)
>  			family->post_doit(ops, skb, info);
> =20
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  	kfree(__bp_genl_info_userhdr(info));
>  #endif
>  }
> =20
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  int backport_genl_register_family(struct genl_family *family)
>  {
>  	struct genl_ops *ops;
> @@ -237,7 +244,8 @@ int backport_genl_register_family(struct genl_famil=
y *family)
>  	 * memory layout isn't compatible with the old version
>  	 */
>  	for (i =3D 0; i < family->n_ops; i++) {
> -#if LINUX_VERSION_IS_LESS(4,12,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
>  		if (ops[i].doit)
>  			ops[i].doit =3D extack_doit;
>  #endif
> @@ -311,6 +319,7 @@ int backport_genl_unregister_family(struct genl_fam=
ily *family)
>  	return __real_backport_genl_unregister_family(&family->family);
>  }
>  EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
> +#endif
> =20
>  #define INVALID_GROUP	0xffffffff
> =20
> @@ -441,3 +450,4 @@ int backport_genlmsg_multicast_allns(const struct g=
enl_family *family,
>  	return genlmsg_mcast(skb, portid, group, flags);
>  }
>  EXPORT_SYMBOL_GPL(backport_genlmsg_multicast_allns);
> +#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6) */

Please check again if all these ifdefs for redhat are needed in this
function. It looks like there are some bigger ifdes around most of the
code in here.

> diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-se=
lect_queue/mac80211.patch
> index f488589dd379..45cf0faa09f4 100644
> --- a/patches/0028-select_queue/mac80211.patch
> +++ b/patches/0028-select_queue/mac80211.patch
> @@ -1,6 +1,6 @@
>  --- a/net/mac80211/iface.c
>  +++ b/net/mac80211/iface.c
> -@@ -1128,9 +1128,29 @@ static void ieee80211_uninit(struct net_
> +@@ -1128,9 +1128,30 @@ static void ieee80211_uninit(struct net_
>   	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
>   }
>  =20
> @@ -14,7 +14,8 @@
>  +					 struct net_device *sb_dev,
>  +					 select_queue_fallback_t fallback)
>  +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
> -+    (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30)
> ++    (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30) || \
> ++       RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
>  +					 struct sk_buff *skb,
>  +					 void *accel_priv,
> @@ -30,7 +31,7 @@
>   {
>   	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
>   }
> -@@ -1173,9 +1193,29 @@ static const struct net_device_ops ieee8
> +@@ -1173,9 +1193,30 @@ static const struct net_device_ops ieee8
>   	.ndo_get_stats64	=3D ieee80211_get_stats64,
>   };
>  =20
> @@ -44,7 +45,8 @@
>  +					  struct net_device *sb_dev,
>  +					  select_queue_fallback_t fallback)
>  +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
> -+    (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30)
> ++    (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(3,13,11) && UTS_UBUNTU_=
RELEASE_ABI > 30) || \
> ++       RHEL_RELEASE_CODE >=3D RHEL_RELEASE_VERSION(7,6)
>  +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
>  +					  struct sk_buff *skb,
>  +					  void *accel_priv,
> diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netd=
evice-mtu-range.cocci
> index 7a4b65322803..7f902c7a09eb 100644
> --- a/patches/0073-netdevice-mtu-range.cocci
> +++ b/patches/0073-netdevice-mtu-range.cocci
> @@ -73,7 +73,7 @@ func(...) {
>  constant r1.e1,r1.e2;
>  identifier r.OPS;
>  @@
> -+#if LINUX_VERSION_IS_LESS(4,10,0)
> ++#if LINUX_VERSION_IS_LESS(4,10,0) && RHEL_RELEASE_CODE < RHEL_RELEASE=
_VERSION(7,6)
>  + static int __change_mtu(struct net_device *ndev, int new_mtu)
>  + {
>  + if (new_mtu < e1 || new_mtu > e2)
> @@ -92,7 +92,7 @@ identifier OPS;
>  @@
> =20
>  struct net_device_ops OPS =3D {
> -+#if LINUX_VERSION_IS_LESS(4,10,0)
> ++#if LINUX_VERSION_IS_LESS(4,10,0) && RHEL_RELEASE_CODE < RHEL_RELEASE=
_VERSION(7,6)
>  +      .ndo_change_mtu =3D __change_mtu,
>  +#endif
>         ...
> diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-6=
4.cocci
> index 8971a97c7209..f23059f3ba10 100644
> --- a/patches/0075-ndo-stats-64.cocci
> +++ b/patches/0075-ndo-stats-64.cocci
> @@ -5,7 +5,7 @@ fresh identifier stats64_fn_wrap =3D "bp_" ## stats64_f=
n;
>  position p;
>  @@
>  struct net_device_ops OPS@p =3D {
> -+#if LINUX_VERSION_IS_GEQ(4,11,0)
> ++#if LINUX_VERSION_IS_GEQ(4,11,0) || RHEL_RELEASE_CODE >=3D RHEL_RELEA=
SE_VERSION(7,6)
>  	.ndo_get_stats64 =3D stats64_fn,
>  +#else
>  +	.ndo_get_stats64 =3D stats64_fn_wrap,
> @@ -17,7 +17,7 @@ identifier r.stats64_fn_wrap;
>  identifier r.stats64_fn;
>  @@
>  void stats64_fn(...) {...}
> -+#if LINUX_VERSION_IS_LESS(4,11,0)
> ++#if LINUX_VERSION_IS_LESS(4,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE=
_VERSION(7,6)
>  +/* Just declare it here to keep sparse happy */
>  +struct rtnl_link_stats64 *
>  +stats64_fn_wrap(struct net_device *dev,
>=20



--hVJQ4Nf5eXLcsxY6YRNRCo1xjvDWfShKD--

--4K80s2J6DnCia6ZXxlxBm0Q8AidsBoxG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl5S+6MACgkQ8bdnhZyy
68fErQf6ApVz6Rw5LNONk6hb+UaByEI6xEYH3A5oCewAzzo1IDn1JlSqe5h4EZCv
QZyu8aOBsy/XExjGGPC/5ZT4GE5nGXeg4k7xYvZSHYcOD5ZU7skewSQOYwbz1HNQ
gT6u9zz0H5rhfsdBcOowzb4HDhDp2QWvXHfa+PMp0iHsLQho/KjH3g9IKPOt4ioQ
auXpNT6F/qbpMn2CU1goJsJrrMiN6RWgDHKH87AuoAuhC9skkxCbUQuVZxE8GA5F
F2Ivl16FU2Uj2hRbMGBGLUMjyMg+mtVF8JI7e4HYnRaFezijv0E75SZMHx67rDrv
svphLxu5wzn7WlqK0DkIDHoOswhegQ==
=itvU
-----END PGP SIGNATURE-----

--4K80s2J6DnCia6ZXxlxBm0Q8AidsBoxG7--

--
To unsubscribe from this list: send the line "unsubscribe backports" in
