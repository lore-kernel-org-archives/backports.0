MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
References: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
Date: Sat, 27 Oct 2012 08:01:52 -0700
Message-ID: <CAB=NE6X-w7c=CZC0_27vW14PO30i_81Tqcr1sawuMch3SDk=Rw@mail.gmail.com>
Subject: Re: Regarding compat_autoconf.h generation
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Oct 27, 2012 at 7:25 AM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> Hi,
>
> In the nouveau DRM driver there is a CONFIG_NOUVEAU_DEBUG which has to
> be an integer between 0 and 7 with the default as 3.
> Currently gen-compat-autoconf.sh defines this as a string by default:
>
>            *) # Assume string
>  61                 # XXX: add better checks to make sure what was on
>  62                 # the right was indeed a string
>  63                 echo "#ifndef $VAR"
>  64                 echo "#define $VAR \"$VALUE\""
>  65                 echo "#endif /* $VAR */ "
>  66                 ;;
>
> Is it OK to modify the script to allow defining integers?

Sure :)

> Also, it
> seems that there is no difference with =3Dm and =3Dy:
>
>               y)
>  51                 echo "#ifndef $VAR"
>  52                 echo "#define $VAR 1"
>  53                 echo "#endif /* $VAR */ "
>  54                 ;;
>  55         m)
>  56                 echo "#ifndef $VAR"
>  57                 echo "#define $VAR 1"
>  58                 echo "#endif /* $VAR */ "
>  59                 ;;
>
> How come this doesn't break things?

The real magic for "y" or "m" happens via Kconfig and Makefiles, the
header file is just at compile time of C code.

> Both =3Dy and =3Dm exist in config.mk.

We try to replicate what the kernel does, but m should always be used
for modules otherwise they won't build. For an example fix see
f456f3e174c65a6f5c8e34693b7f89ad52d9b072.

  Luis
