Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40522 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbbAWXLI (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Jan 2015 18:11:08 -0500
Message-ID: <54C2D50A.10600@hauke-m.de> (sfid-20150124_001111_320178_A838F6B6)
Date: Sat, 24 Jan 2015 00:11:06 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Mathieu Olivari <mathieu@qca.qualcomm.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 2/2] backport: add hwmon group registration functions
References: <1421115476-11855-1-git-send-email-mathieu@qca.qualcomm.com> <1421115476-11855-2-git-send-email-mathieu@qca.qualcomm.com>
In-Reply-To: <1421115476-11855-2-git-send-email-mathieu@qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 01/13/2015 03:17 AM, Mathieu Olivari wrote:
> hwmon group registration functions have been added in 3.13 kernel.
> Latest ath10k patches make use of this mechanism, therefore the
> need for the backport.
> 
> Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>
> ---
>  backport/backport-include/linux/hwmon.h |   36 +++++++++++++++++++++++
>  backport/compat/backport-3.13.c         |   47 +++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 backport/backport-include/linux/hwmon.h
> 
> diff --git a/backport/backport-include/linux/hwmon.h b/backport/backport-include/linux/hwmon.h
> new file mode 100644
> index 0000000..961e979
> --- /dev/null
> +++ b/backport/backport-include/linux/hwmon.h
> @@ -0,0 +1,36 @@
> +#ifndef __BACKPORT_LINUX_HWMON_H
> +#define __BACKPORT_LINUX_HWMON_H
> +#include_next <linux/hwmon.h>
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
> +/*
> + * Backports
> + *
> + * commit bab2243ce1897865e31ea6d59b0478391f51812b
> + * Author: Guenter Roeck <linux@roeck-us.net>
> + * Date:   Sat Jul 6 13:57:23 2013 -0700
> + *
> + *     hwmon: Introduce hwmon_device_register_with_groups
> + *
> + *     hwmon_device_register_with_groups() lets callers register a hwmon device
> + *     together with all sysfs attributes in a single call.
> + *
> + *     When using hwmon_device_register_with_groups(), hwmon attributes are attached
> + *     to the hwmon device directly and no longer with its parent device.
> + *
> + * Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> + */
> +struct device *
> +hwmon_device_register_with_groups(struct device *dev, const char *name,
> +				  void *drvdata,
> +				  const struct attribute_group **groups);
> +struct device *
> +devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
> +				       void *drvdata,
> +				       const struct attribute_group **groups);
> +void devm_hwmon_release(struct device *dev, void *res);

devm_hwmon_release() can get removed here when you make it static.

> +
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
> +
> +#endif /* __BACKPORT_LINUX_HWMON_H */
> diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
> index 553ed8f..89100a2 100644
> --- a/backport/compat/backport-3.13.c
> +++ b/backport/compat/backport-3.13.c
> @@ -252,3 +252,50 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);
>  #endif /* CONFIG_PCI */
> +
> +#ifdef CONFIG_HWMON
> +#include <linux/device.h>
> +#include <linux/hwmon.h>

You can move the includes to the top of the file.

> +struct device*
> +hwmon_device_register_with_groups(struct device *dev, const char *name,
> +				  void *drvdata,
> +				  const struct attribute_group **groups)
> +{
> +	return hwmon_device_register(dev);

You should probably set dev->groups and the drvdata.

> +}
> +
> +struct device *
> +devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
> +				       void *drvdata,
> +				       const struct attribute_group **groups)
> +{
> +	struct device **ptr, *hwdev;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hwdev = hwmon_device_register_with_groups(dev, name, drvdata, groups);
> +	if (IS_ERR(hwdev))
> +		goto error;
> +
> +	*ptr = hwdev;
> +	devres_add(dev, ptr);
> +	return hwdev;
> +
> +error:
> +	devres_free(ptr);
> +	return hwdev;
> +}
> +EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
> +
> +void devm_hwmon_release(struct device *dev, void *res)

You should make this function static and move it before
devm_hwmon_device_register_with_group().

> +{
> +	struct device *hwdev = *(struct device **)res;
> +
> +	hwmon_device_unregister(hwdev);
> +}
> +#endif
> 
