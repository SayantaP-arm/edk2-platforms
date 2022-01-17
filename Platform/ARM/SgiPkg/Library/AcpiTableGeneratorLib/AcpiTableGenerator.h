/** @file

  Copyright (c) 2022, Arm Limited. All rights reserved.<BR>

  SPDX-License-Identifier: BSD-2-Clause-Patent
**/

#ifndef __ACPI_TABLE_GENERATOR_H__
#define __ACPI_TABLE_GENERATOR_H__

#include <Library/AcpiLib.h>
#include <Library/AmlLib/AmlLib.h>
#include <Library/BaseLib.h>
#include <Library/BaseMemoryLib.h>
#include <Library/DebugLib.h>
#include <Library/IoLib.h>
#include <Library/MemoryAllocationLib.h>
#include <Library/PcdLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Protocol/AcpiTable.h>
#include <Protocol/Cxl.h>
#include <SgiAcpiHeader.h>
#include <SgiPlatform.h>

#define LOWER_BYTES_MASK   0xFFFFF000
#define LOWER_BYTES_SHIFT  32

EFI_STATUS EFIAPI SratTableGenerator (
  EFI_ACPI_TABLE_PROTOCOL *mAcpiTableProtocol
  );

EFI_STATUS EFIAPI HmatTableGenerator (
  EFI_ACPI_TABLE_PROTOCOL *mAcpiTableProtocol
  );

#endif // __ACPI_TABLE_GENERATOR_H__
