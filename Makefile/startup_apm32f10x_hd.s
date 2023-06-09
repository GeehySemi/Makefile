;/*!
; * @file        startup_apm32f10x_hd.s
; *
; * @brief       CMSIS Cortex-M3 based Core Device Startup File for Device startup_apm32f10x_hd
; *
; * @version     V1.0.0
; *
; * @date        2022-05-27
; *
; * @attention
; *
; *  Copyright (C) 2020-2022 Geehy Semiconductor
; *
; *  You may not use this file except in compliance with the
; *  GEEHY COPYRIGHT NOTICE (GEEHY SOFTWARE PACKAGE LICENSE).
; *
; *  The program is only for reference, which is distributed in the hope
; *  that it will be usefull and instructional for customers to develop
; *  their software. Unless required by applicable law or agreed to in
; *  writing, the program is distributed on an "AS IS" BASIS, WITHOUT
; *  ANY WARRANTY OR CONDITIONS OF ANY KIND, either express or implied.
; *  See the GEEHY SOFTWARE PACKAGE LICENSE for the governing permissions
; *  and limitations under the License.
; */

  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

.global g_pfnVectors
.global Default_Handler

/* start address for the initialization values of the .data section.
defined in linker script */
.word _sidata
/* start address for the .data section. defined in linker script */
.word _sdata
/* end address for the .data section. defined in linker script */
.word _edata
/* start address for the .bss section. defined in linker script */
.word _sbss
/* end address for the .bss section. defined in linker script */
.word _ebss

.equ  BootRAM,        0xF1E0F85F
/**
 * @brief  This is the code that gets called when the processor first
 *          starts execution following a reset event. Only the absolutely
 *          necessary set is performed, after which the application
 *          supplied main() routine is called.
 * @param  None
 * @retval : None
*/

  .section .text.Reset_Handler
  .weak Reset_Handler
  .type Reset_Handler, %function
Reset_Handler:

/* Copy the data segment initializers from flash to SRAM */
  ldr r0, =_sdata
  ldr r1, =_edata
  ldr r2, =_sidata
  movs r3, #0
  b LoopCopyDataInit

CopyDataInit:
  ldr r4, [r2, r3]
  str r4, [r0, r3]
  adds r3, r3, #4

LoopCopyDataInit:
  adds r4, r0, r3
  cmp r4, r1
  bcc CopyDataInit
  
/* Zero fill the bss segment. */
  ldr r2, =_sbss
  ldr r4, =_ebss
  movs r3, #0
  b LoopFillZerobss

FillZerobss:
  str  r3, [r2]
  adds r2, r2, #4

LoopFillZerobss:
  cmp r2, r4
  bcc FillZerobss

/* Call the clock system intitialization function.*/
    bl  SystemInit
/* Call static constructors */
    bl __libc_init_array
/* Call the application's entry point.*/
  bl main
  bx lr
.size Reset_Handler, .-Reset_Handler

/**
 * @brief  This is the code that gets called when the processor receives an
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 *
 * @param  None
 * @retval : None
*/
    .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b Infinite_Loop
  .size Default_Handler, .-Default_Handler
/******************************************************************************
*
* The minimal vector table for a Cortex M3.  Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
*
******************************************************************************/
  .section .isr_vector,"a",%progbits
  .type g_pfnVectors, %object
  .size g_pfnVectors, .-g_pfnVectors


g_pfnVectors:

  .word _estack
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
  .word MemManage_Handler
  .word BusFault_Handler
  .word UsageFault_Handler
  .word 0
  .word 0
  .word 0
  .word 0
  .word SVC_Handler
  .word DebugMon_Handler
  .word 0
  .word PendSV_Handler
  .word SysTick_Handler
  .word WWDT_IRQHandler
  .word PVD_IRQHandler
  .word TAMPER_IRQHandler
  .word RTC_IRQHandler
  .word FLASH_IRQHandler
  .word RCM_IRQHandler
  .word EINT0_IRQHandler
  .word EINT1_IRQHandler
  .word EINT2_IRQHandler
  .word EINT3_IRQHandler
  .word EINT4_IRQHandler
  .word DMA1_Channel1_IRQHandler
  .word DMA1_Channel2_IRQHandler
  .word DMA1_Channel3_IRQHandler
  .word DMA1_Channel4_IRQHandler
  .word DMA1_Channel5_IRQHandler
  .word DMA1_Channel6_IRQHandler
  .word DMA1_Channel7_IRQHandler
  .word ADC1_2_IRQHandler
  .word USBD_HP_CAN1_TX_IRQHandler
  .word USBD_LP_CAN1_RX0_IRQHandler
  .word CAN1_RX1_IRQHandler
  .word CAN1_SCE_IRQHandler
  .word EINT9_5_IRQHandler
  .word TMR1_BRK_IRQHandler
  .word TMR1_UP_IRQHandler
  .word TMR1_TRG_COM_IRQHandler
  .word TMR1_CC_IRQHandler
  .word TMR2_IRQHandler
  .word TMR3_IRQHandler
  .word TMR4_IRQHandler
  .word I2C1_EV_IRQHandler
  .word I2C1_ER_IRQHandler
  .word I2C2_EV_IRQHandler
  .word I2C2_ER_IRQHandler
  .word SPI1_IRQHandler
  .word SPI2_IRQHandler
  .word USART1_IRQHandler
  .word USART2_IRQHandler
  .word USART3_IRQHandler
  .word EINT15_10_IRQHandler
  .word RTC_Alarm_IRQHandler
  .word USBDWakeUp_IRQHandler
  .word TMR8_BRK_IRQHandler
  .word TMR8_UP_IRQHandler
  .word TMR8_TRG_COM_IRQHandler
  .word TMR8_CC_IRQHandler
  .word ADC3_IRQHandler
  .word FSMC_IRQHandler
  .word SDIO_IRQHandler
  .word TMR5_IRQHandler
  .word SPI3_IRQHandler
  .word UART4_IRQHandler
  .word UART5_IRQHandler
  .word TMR6_IRQHandler
  .word TMR7_IRQHandler
  .word DMA2_Channel1_IRQHandler
  .word DMA2_Channel2_IRQHandler
  .word DMA2_Channel3_IRQHandler
  .word DMA2_Channel4_5_IRQHandler
  .word 0                                  // Reserved
  .word USBD2_HP_CAN2_TX_IRQHandler        // USBD2 High Priority or CAN2 TX
  .word USBD2_LP_CAN2_RX0_IRQHandler       // USBD2 Low  Priority or CAN2 RX0
  .word CAN2_RX1_IRQHandler                // CAN2 RX1
  .word CAN2_SCE_IRQHandler                // CAN2 SCE
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word BootRAM       /* @0x1E0. This is for boot in RAM mode for
                         APM32F10x High Density devices. */

/*******************************************************************************
*
* Provide weak aliases for each Exception handler to the Default_Handler.
* As they are weak aliases, any function with the same name will override
* this definition.
*
*******************************************************************************/

  .weak NMI_Handler
  .thumb_set NMI_Handler,Default_Handler

  .weak HardFault_Handler
  .thumb_set HardFault_Handler,Default_Handler

  .weak MemManage_Handler
  .thumb_set MemManage_Handler,Default_Handler

  .weak BusFault_Handler
  .thumb_set BusFault_Handler,Default_Handler

  .weak UsageFault_Handler
  .thumb_set UsageFault_Handler,Default_Handler

  .weak SVC_Handler
  .thumb_set SVC_Handler,Default_Handler

  .weak DebugMon_Handler
  .thumb_set DebugMon_Handler,Default_Handler

  .weak PendSV_Handler
  .thumb_set PendSV_Handler,Default_Handler

  .weak SysTick_Handler
  .thumb_set SysTick_Handler,Default_Handler

  .weak WWDT_IRQHandler
  .thumb_set WWDT_IRQHandler,Default_Handler

  .weak PVD_IRQHandler
  .thumb_set PVD_IRQHandler,Default_Handler

  .weak TAMPER_IRQHandler
  .thumb_set TAMPER_IRQHandler,Default_Handler

  .weak RTC_IRQHandler
  .thumb_set RTC_IRQHandler,Default_Handler

  .weak FLASH_IRQHandler
  .thumb_set FLASH_IRQHandler,Default_Handler

  .weak RCM_IRQHandler
  .thumb_set RCM_IRQHandler,Default_Handler

  .weak EINT0_IRQHandler
  .thumb_set EINT0_IRQHandler,Default_Handler

  .weak EINT1_IRQHandler
  .thumb_set EINT1_IRQHandler,Default_Handler

  .weak EINT2_IRQHandler
  .thumb_set EINT2_IRQHandler,Default_Handler

  .weak EINT3_IRQHandler
  .thumb_set EINT3_IRQHandler,Default_Handler

  .weak EINT4_IRQHandler
  .thumb_set EINT4_IRQHandler,Default_Handler

  .weak DMA1_Channel1_IRQHandler
  .thumb_set DMA1_Channel1_IRQHandler,Default_Handler

  .weak DMA1_Channel2_IRQHandler
  .thumb_set DMA1_Channel2_IRQHandler,Default_Handler

  .weak DMA1_Channel3_IRQHandler
  .thumb_set DMA1_Channel3_IRQHandler,Default_Handler

  .weak DMA1_Channel4_IRQHandler
  .thumb_set DMA1_Channel4_IRQHandler,Default_Handler

  .weak DMA1_Channel5_IRQHandler
  .thumb_set DMA1_Channel5_IRQHandler,Default_Handler

  .weak DMA1_Channel6_IRQHandler
  .thumb_set DMA1_Channel6_IRQHandler,Default_Handler

  .weak DMA1_Channel7_IRQHandler
  .thumb_set DMA1_Channel7_IRQHandler,Default_Handler

  .weak ADC1_2_IRQHandler
  .thumb_set ADC1_2_IRQHandler,Default_Handler

  .weak USBD_HP_CAN1_TX_IRQHandler
  .thumb_set USBD_HP_CAN1_TX_IRQHandler,Default_Handler

  .weak USBD_LP_CAN1_RX0_IRQHandler
  .thumb_set USBD_LP_CAN1_RX0_IRQHandler,Default_Handler

  .weak CAN1_RX1_IRQHandler
  .thumb_set CAN1_RX1_IRQHandler,Default_Handler

  .weak CAN1_SCE_IRQHandler
  .thumb_set CAN1_SCE_IRQHandler,Default_Handler

  .weak EINT9_5_IRQHandler
  .thumb_set EINT9_5_IRQHandler,Default_Handler

  .weak TMR1_BRK_IRQHandler
  .thumb_set TMR1_BRK_IRQHandler,Default_Handler

  .weak TMR1_UP_IRQHandler
  .thumb_set TMR1_UP_IRQHandler,Default_Handler

  .weak TMR1_TRG_COM_IRQHandler
  .thumb_set TMR1_TRG_COM_IRQHandler,Default_Handler

  .weak TMR1_CC_IRQHandler
  .thumb_set TMR1_CC_IRQHandler,Default_Handler

  .weak TMR2_IRQHandler
  .thumb_set TMR2_IRQHandler,Default_Handler

  .weak TMR3_IRQHandler
  .thumb_set TMR3_IRQHandler,Default_Handler

  .weak TMR4_IRQHandler
  .thumb_set TMR4_IRQHandler,Default_Handler

  .weak I2C1_EV_IRQHandler
  .thumb_set I2C1_EV_IRQHandler,Default_Handler

  .weak I2C1_ER_IRQHandler
  .thumb_set I2C1_ER_IRQHandler,Default_Handler

  .weak I2C2_EV_IRQHandler
  .thumb_set I2C2_EV_IRQHandler,Default_Handler

  .weak I2C2_ER_IRQHandler
  .thumb_set I2C2_ER_IRQHandler,Default_Handler

  .weak SPI1_IRQHandler
  .thumb_set SPI1_IRQHandler,Default_Handler

  .weak SPI2_IRQHandler
  .thumb_set SPI2_IRQHandler,Default_Handler

  .weak USART1_IRQHandler
  .thumb_set USART1_IRQHandler,Default_Handler

  .weak USART2_IRQHandler
  .thumb_set USART2_IRQHandler,Default_Handler

  .weak USART3_IRQHandler
  .thumb_set USART3_IRQHandler,Default_Handler

  .weak EINT15_10_IRQHandler
  .thumb_set EINT15_10_IRQHandler,Default_Handler

  .weak RTC_Alarm_IRQHandler
  .thumb_set RTC_Alarm_IRQHandler,Default_Handler

  .weak USBDWakeUp_IRQHandler
  .thumb_set USBDWakeUp_IRQHandler,Default_Handler

  .weak TMR8_BRK_IRQHandler
  .thumb_set TMR8_BRK_IRQHandler,Default_Handler

  .weak TMR8_UP_IRQHandler
  .thumb_set TMR8_UP_IRQHandler,Default_Handler

  .weak TMR8_TRG_COM_IRQHandler
  .thumb_set TMR8_TRG_COM_IRQHandler,Default_Handler

  .weak TMR8_CC_IRQHandler
  .thumb_set TMR8_CC_IRQHandler,Default_Handler

  .weak ADC3_IRQHandler
  .thumb_set ADC3_IRQHandler,Default_Handler

  .weak FSMC_IRQHandler
  .thumb_set FSMC_IRQHandler,Default_Handler

  .weak SDIO_IRQHandler
  .thumb_set SDIO_IRQHandler,Default_Handler

  .weak TMR5_IRQHandler
  .thumb_set TMR5_IRQHandler,Default_Handler

  .weak SPI3_IRQHandler
  .thumb_set SPI3_IRQHandler,Default_Handler

  .weak UART4_IRQHandler
  .thumb_set UART4_IRQHandler,Default_Handler

  .weak UART5_IRQHandler
  .thumb_set UART5_IRQHandler,Default_Handler

  .weak TMR6_IRQHandler
  .thumb_set TMR6_IRQHandler,Default_Handler

  .weak TMR7_IRQHandler
  .thumb_set TMR7_IRQHandler,Default_Handler

  .weak DMA2_Channel1_IRQHandler
  .thumb_set DMA2_Channel1_IRQHandler,Default_Handler

  .weak DMA2_Channel2_IRQHandler
  .thumb_set DMA2_Channel2_IRQHandler,Default_Handler

  .weak DMA2_Channel3_IRQHandler
  .thumb_set DMA2_Channel3_IRQHandler,Default_Handler

  .weak DMA2_Channel4_5_IRQHandler
  .thumb_set DMA2_Channel4_5_IRQHandler,Default_Handler

  .weak USBD2_HP_CAN2_TX_IRQHandler
  .thumb_set USBD2_HP_CAN2_TX_IRQHandler,Default_Handler

  .weak USBD2_LP_CAN2_RX0_IRQHandler
  .thumb_set USBD2_LP_CAN2_RX0_IRQHandler,Default_Handler

  .weak CAN2_RX1_IRQHandler
  .thumb_set CAN2_RX1_IRQHandler,Default_Handler

  .weak CAN2_SCE_IRQHandler
  .thumb_set CAN2_SCE_IRQHandler,Default_Handler

