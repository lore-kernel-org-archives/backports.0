Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:60683
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751737Ab3HPOXa (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 10:23:30 -0400
Date: Fri, 16 Aug 2013 10:23:19 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with
 kernels < 3.2
Message-ID: <20130816142318.GA6262@shaftnet.org> (sfid-20130816_162332_529737_B8859C48)
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org>
 <1376571357-16506-2-git-send-email-pizza@shaftnet.org>
 <20130816030715.GB9574@garbanzo.do-not-panic.com>
 <520E012F.6020108@hauke-m.de>
 <20130816114726.GC28867@shaftnet.org>
 <520E261B.9070304@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <520E261B.9070304@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 03:16:11PM +0200, Hauke Mehrtens wrote:
> I tested this on an amd64 system, it could be that it works on some
> other archs.

Yeah, I was building this on arm.

> Yes you should put it into backport/compat/backport-3.10.c.
> I am still wondering if get_random_int() is needed for such an
> algorithm at all.

I'm not sure what you mean by this.  This is get_random_int() in current=20
kernels: (copied from 3.11-rc)

/*
 * Get a random word for internal kernel use only. Similar to urandom but
 * with the goal of minimal entropy pool depletion. As a result, the random
 * value is not cryptographically secure but for several uses the cost of
 * depleting entropy is too high
 */
static DEFINE_PER_CPU(__u32 [MD5_DIGEST_WORDS], get_random_int_hash);
unsigned int get_random_int(void)
{
        __u32 *hash;
        unsigned int ret;

        if (arch_get_random_int(&ret))
                return ret;

        hash =3D get_cpu_var(get_random_int_hash);

        hash[0] +=3D current->pid + jiffies + get_cycles();
        md5_transform(hash, random_int_secret);
        ret =3D hash[0];
        put_cpu_var(get_random_int_hash);

        return ret;
}

The cw1200 driver calls get_random_int() on every tx paket when there is=20
QoS/queue contention to determine random backoff intervals.  The numbers=20
don't need to be cryptographically secure, just "different" -- and=20
there's really no point in sucking the kernel entropy pool dry to do=20
this when it could happen on nearly every frame we transmit.  IOW, this=20
is the perfect situation for get_random_int() vs get_random_bytes().

I wonder if it's worth backporting this whole thing (possibly minus=20
arch_get_random_int()) or just re-implementing it using=20
get_random_bytes() instead:

unsigned int get_random_int(void)
{
	int r;
	get_random_bytes(&r, sizeof(r));

	return r;
}

After all, this logic is what any modules would have had would have had=20
to use prior to 3.10.

Any thoughts on this?

> I uploaded a logfile with some error messages:
> http://hauke-m.de/files/compat-wireless/ckmake.log

Thanks, I will look into this tonight.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSDjXWPuLgii2759ARAlQYAKC18NOZ0kl1ZgLKLSIKa/R22h1WdQCgzLhW
+t0pGNqdNcAX/zoLDnQ4TbQ=
=hL9w
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
