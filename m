Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:55275 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbcGHTuA (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 8 Jul 2016 15:50:00 -0400
Subject: Re: [PATCH] backport: add thermal backports for kernels < 4.3
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
References: <1455356813-4863-1-git-send-email-luca@coelho.fi>
Cc: emmanuel.grumbach@intel.com
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <06392fc7-23f8-0434-8e39-27ee4239363b@hauke-m.de> (sfid-20160708_215019_501714_61704318)
Date: Fri, 8 Jul 2016 21:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <1455356813-4863-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/13/2016 10:46 AM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> There were some API changes in the thermal framework in kernel version
> 4.3 and also earlier in 3.10.  Backport what is needed to support
> older kernels.
> 
> The 4.3 change is a bit tricky, because it changes the prototypes of
> some ops.  The solution for that is to add hook functions that will
> intercept the calls from the thermal framework and convert them to
> calls that the backported driver provides (namely convert unsigned
> longs to ints).

If it is just some int or unsigned long I think it is easier to just
have a patch or spatch for your driver. I assume that your program logic
does not care about the type.

> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Sorry that it took me so long to look into this.

> 
> This will be needed by a upcoming patches for the iwlwifi driver that
> include some thermal framework functionality.  Already sending this
> out so that it can be added before our driver breaks. ;)
> 
> backport-include/linux/thermal.h | 109 ++++++++++++++++++++++++++++++++
>  backport/compat/backport-4.3.c   | 131 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 backport-include/linux/thermal.h
> 
> diff --git a/backport-include/linux/thermal.h b/backport-include/linux/thermal.h
> new file mode 100644
> index 0000000..dbcb4be
> --- /dev/null
> +++ b/backport-include/linux/thermal.h
> @@ -0,0 +1,109 @@
> +#ifndef __BACKPORT_LINUX_THERMAL_H
> +#define __BACKPORT_LINUX_THERMAL_H
> +#include_next <linux/thermal.h>
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
> +#define thermal_notify_framework notify_thermal_framework
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
> +
> +/* Declare the < 4.3.0 struct so we can use it when calling the outer
> + * kernel.
> + */
> +struct old_thermal_zone_device_ops {
> +	int (*bind) (struct thermal_zone_device *,
> +		     struct thermal_cooling_device *);
> +	int (*unbind) (struct thermal_zone_device *,
> +		       struct thermal_cooling_device *);
> +	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*get_mode) (struct thermal_zone_device *,
> +			 enum thermal_device_mode *);
> +	int (*set_mode) (struct thermal_zone_device *,
> +		enum thermal_device_mode);
> +	int (*get_trip_type) (struct thermal_zone_device *, int,
> +		enum thermal_trip_type *);
> +	int (*get_trip_temp) (struct thermal_zone_device *, int,
> +			      unsigned long *);
> +	int (*set_trip_temp) (struct thermal_zone_device *, int,
> +			      unsigned long);
> +	int (*get_trip_hyst) (struct thermal_zone_device *, int,
> +			      unsigned long *);
> +	int (*set_trip_hyst) (struct thermal_zone_device *, int,
> +			      unsigned long);
> +	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
> +	int (*get_trend) (struct thermal_zone_device *, int,
> +			  enum thermal_trend *);
> +	int (*notify) (struct thermal_zone_device *, int,
> +		       enum thermal_trip_type);
> +};

Why are you putting this struct here? Why can't you use the "struct
thermal_zone_device_ops" from the kernel you are compiling against. In
kernel 3.10 it is mostly the same in kernel 3.0 it misses some members.

> +
> +/* also add a way to call the old register function */
> +static inline struct thermal_zone_device *old_thermal_zone_device_register(
> +	const char *type, int trips, int mask, void *devdata,
> +	struct old_thermal_zone_device_ops *_ops,
> +	const struct thermal_zone_params *tzp,
> +	int passive_delay, int polling_delay)
> +{
> +	struct thermal_zone_device_ops *ops =
> +		(struct thermal_zone_device_ops *) _ops;
> +
> +	return thermal_zone_device_register(type, trips, mask, devdata,
> +					    ops, tzp, passive_delay,
> +					    polling_delay);
> +}

Why is this function needed here, you are only calling it in
backport_thermal_zone_device_register() and it could be included there.

> +
> +#undef thermal_zone_device_ops
> +struct backport_thermal_zone_device_ops {
> +	int (*bind) (struct thermal_zone_device *,
> +		     struct thermal_cooling_device *);
> +	int (*unbind) (struct thermal_zone_device *,
> +		       struct thermal_cooling_device *);
> +	int (*get_temp) (struct thermal_zone_device *, int *);
> +	int (*get_mode) (struct thermal_zone_device *,
> +			 enum thermal_device_mode *);
> +	int (*set_mode) (struct thermal_zone_device *,
> +		enum thermal_device_mode);
> +	int (*get_trip_type) (struct thermal_zone_device *, int,
> +		enum thermal_trip_type *);
> +	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
> +	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
> +	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
> +	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
> +	int (*get_crit_temp) (struct thermal_zone_device *, int *);
> +	int (*set_emul_temp) (struct thermal_zone_device *, int);
> +	int (*get_trend) (struct thermal_zone_device *, int,
> +			  enum thermal_trend *);
> +	int (*notify) (struct thermal_zone_device *, int,
> +		       enum thermal_trip_type);
> +
> +	/* These ops hold the original callbacks set by the
> +	 * registrant, because we'll add our hooks to the ones called
> +	 * by the framework.  Luckily someone made this ops struct
> +	 * non-const so we can mangle them.
> +	 */
> +	int (*_get_temp) (struct thermal_zone_device *, int *);
> +	int (*_get_trip_temp) (struct thermal_zone_device *, int, int *);
> +	int (*_set_trip_temp) (struct thermal_zone_device *, int, int);
> +	int (*_get_trip_hyst) (struct thermal_zone_device *, int, int *);
> +	int (*_set_trip_hyst) (struct thermal_zone_device *, int, int);
> +	int (*_get_crit_temp) (struct thermal_zone_device *, int *);
> +	int (*_set_emul_temp) (struct thermal_zone_device *, int);
> +};
> +#define thermal_zone_device_ops LINUX_BACKPORT(thermal_zone_device_ops)
> +
> +#undef thermal_zone_device_register
> +struct thermal_zone_device *backport_thermal_zone_device_register(
> +	const char *type, int trips, int mask, void *devdata,
> +	struct thermal_zone_device_ops *ops,
> +	const struct thermal_zone_params *tzp,
> +	int passive_delay, int polling_delay);
> +
> +#define thermal_zone_device_register \
> +	LINUX_BACKPORT(thermal_zone_device_register)
> +
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
> +
> +#endif /* __BACKPORT_LINUX_THERMAL_H */
> diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
> index d15c92c..193641d 100644
> --- a/backport/compat/backport-4.3.c
> +++ b/backport/compat/backport-4.3.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
> + * Copyright (c) 2015 - 2016 Intel Deutschland GmbH
>   *
>   * Backport functionality introduced in Linux 4.3.
>   *
> @@ -11,6 +12,136 @@
>  #include <linux/seq_file.h>
>  #include <linux/export.h>
>  #include <linux/printk.h>
> +#include <linux/thermal.h>
> +
> +static int backport_thermal_get_temp(struct thermal_zone_device *dev,
> +				     unsigned long *temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +	int _temp, ret;
> +
> +	ret = ops->_get_temp(dev, &_temp);
> +	if (!ret)
> +		*temp = (unsigned long)_temp;
> +
> +	return ret;
> +}
> +
> +static int backport_thermal_get_trip_temp(struct thermal_zone_device *dev, int i,
> +					  unsigned long *temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +	int _temp, ret;
> +
> +	ret = ops->_get_trip_temp(dev, i,  &_temp);
> +	if (!ret)
> +		*temp = (unsigned long)_temp;
> +
> +	return ret;
> +}
> +
> +static int backport_thermal_set_trip_temp(struct thermal_zone_device *dev, int i,
> +					  unsigned long temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +
> +	return ops->_set_trip_temp(dev, i, (int)temp);
> +}
> +
> +static int backport_thermal_get_trip_hyst(struct thermal_zone_device *dev, int i,
> +					  unsigned long *temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +	int _temp, ret;
> +
> +	ret = ops->_get_trip_hyst(dev, i, &_temp);
> +	if (!ret)
> +		*temp = (unsigned long)_temp;
> +
> +	return ret;
> +}
> +
> +static int backport_thermal_set_trip_hyst(struct thermal_zone_device *dev, int i,
> +					  unsigned long temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +
> +	return ops->_set_trip_hyst(dev, i, (int)temp);
> +}
> +
> +static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
> +					  unsigned long *temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +	int _temp, ret;
> +
> +	ret = ops->_get_crit_temp(dev, &_temp);
> +	if (!ret)
> +		*temp = (unsigned long)_temp;
> +
> +	return ret;
> +}
> +
> +static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
> +					  unsigned long temp)
> +{
> +	struct backport_thermal_zone_device_ops *ops =
> +		(struct backport_thermal_zone_device_ops *)dev->ops;
> +
> +	return ops->_set_emul_temp(dev, (int)temp);
> +}
> +
> +struct thermal_zone_device *backport_thermal_zone_device_register(
> +	const char *type, int trips, int mask, void *devdata,
> +	struct backport_thermal_zone_device_ops *ops,
> +	const struct thermal_zone_params *tzp,
> +	int passive_delay, int polling_delay)
> +{
> +	/* It's okay to cast here, because the backport is a superset
> +	 * of the old struct.
> +	 */
> +	struct old_thermal_zone_device_ops *_ops =
> +		(struct old_thermal_zone_device_ops *)ops;
> +
> +	/* store the registrant's ops for the backport ops to use */
> +#define copy_ops(_op) ops->_##_op = ops->_op
> +	copy_ops(get_temp);
> +	copy_ops(get_trip_temp);
> +	copy_ops(set_trip_temp);
> +	copy_ops(get_trip_hyst);
> +	copy_ops(set_trip_hyst);
> +	copy_ops(get_crit_temp);
> +	copy_ops(set_emul_temp);
> +#undef copy_ops
> +
> +	/* Assign the backport ops to the old struct to get the
> +	 * correct types.  But only assign if the registrant defined
> +	 * the ops.
> +	 */
> +#define assign_ops(_op)		\
> +	if (ops->_op)		\
> +		_ops->_op = backport_thermal_##_op
> +
> +	assign_ops(get_temp);
> +	assign_ops(get_trip_temp);
> +	assign_ops(set_trip_temp);
> +	assign_ops(get_trip_hyst);
> +	assign_ops(set_trip_hyst);
> +	assign_ops(get_crit_temp);
> +	assign_ops(set_emul_temp);
> +#undef assign_ops
> +
> +	return old_thermal_zone_device_register(type, trips, mask, devdata,
> +						_ops, tzp, passive_delay,
> +						polling_delay);
> +}
> +EXPORT_SYMBOL_GPL(backport_thermal_zone_device_register);
>  
>  static void seq_set_overflow(struct seq_file *m)
>  {
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
