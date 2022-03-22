/** @file
  Secondary System Description Table (SSDT)

  Copyright (c) 2018 - 2022, Arm Limited. All rights reserved.<BR>

  SPDX-License-Identifier: BSD-2-Clause-Patent

**/

#include "SgiAcpiHeader.h"

DefinitionBlock("SsdtPci.aml", "SSDT", 2, "ARMLTD", "ARMSGI", EFI_ACPI_ARM_OEM_REVISION) {
  Scope (_SB) {
    // PCI Root Complex
    Device (PCI0) {
      Name (_HID, "ACPI0016")        // CXL Host Bridge
      Name (_CID, EISAID("PNP0A03")) // Compatible PCI Root Bridge
      Name (_SEG, Zero)              // PCI Segment Group number
      Name (_BBN, Zero)              // PCI Base Bus Number
      Name (_UID, 1)                 // Unique ID
      Name (_CCA, 1)                 // Cache Coherency Attribute

      // Root complex resources
      Method (_CRS, 0, Serialized) {
        Name (RBUF, ResourceTemplate () {
          WordBusNumber (      // Bus numbers assigned to this root
            ResourceProducer,
            MinFixed,
            MaxFixed,
            PosDecode,
            0,                 // AddressGranularity
            0,                 // AddressMinimum - Minimum Bus Number
            255,               // AddressMaximum - Maximum Bus Number
            0,                 // AddressTranslation - Set to 0
            256                // RangeLength - Number of Busses
            )

          DWordMemory (        // 32-bit BAR Windows
            ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            Cacheable,
            ReadWrite,
            0x00000000,        // Granularity
            0x60000000,        // Min Base Address
            0x6FFFFFFF,        // Max Base Address
            0x00000000,        // Translate
            0x10000000         // Length
            )

          QWordMemory (        // 64-bit BAR Windows
            ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            Cacheable,
            ReadWrite,
            0x00000000,        // Granularity
            0x4000000000,      // Min Base Address
            0x5FFFFFFFFF,      // Max Base Address
            0x00000000,        // Translate
            0x2000000000       // Length
            )

          DWordIo (             // IO window
            ResourceProducer,
            MinFixed,
            MaxFixed,
            PosDecode,
            EntireRange,
            0x00000000,         // Granularity
            0x00000000,         // Min Base Address
            0x007FFFFF,         // Max Base Address
            0x77800000,         // Translate
            0x00800000,         // Length
            ,
            ,
            ,
            TypeTranslation
            )
        }) // Name (RBUF)

        Return (RBUF)
      } // Method (_CRS)

      Device (RES0)
      {
        Name (_HID, "PNP0C02") // PNP Motherboard Resources
        Name (_CRS, ResourceTemplate ()
        {
          QWordMemory (
            ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            NonCacheable,
            ReadWrite,
            0x00000000,
            0x1010000000,  // ECAM Start
            0x101FFFFFFF,  // ECAM End
            0x00000000,
            FixedPcdGet64 (PcdPciExpressBaseSize),   // ECAM Size
            ,
            ,
            ,
            AddressRangeMemory,
            TypeStatic
            )
        })
      }
    }

    Device (CXL1) {   // Host bridge CEDT
      Name (_HID, "ACPI0017")
      Name (_UID, 1)
    }
  }
}
