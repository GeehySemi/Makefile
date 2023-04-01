/*!
 * @file        Board.h
 *
 * @brief       Header file for Board
 *
 * @version     V1.0.2
 *
 * @date        2022-01-05
 *
 * @attention
 *
 *  Copyright (C) 2020-2022 Geehy Semiconductor
 *
 *  You may not use this file except in compliance with the
 *  GEEHY COPYRIGHT NOTICE (GEEHY SOFTWARE PACKAGE LICENSE).
 *
 *  The program is only for reference, which is distributed in the hope
 *  that it will be usefull and instructional for customers to develop
 *  their software. Unless required by applicable law or agreed to in
 *  writing, the program is distributed on an "AS IS" BASIS, WITHOUT
 *  ANY WARRANTY OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the GEEHY SOFTWARE PACKAGE LICENSE for the governing permissions
 *  and limitations under the License.
 */
#ifndef BOARD_H
#define BOARD_H

#if defined (APM32F103_MINI)
#include "Board_APM32F103_MINI.h"

#elif defined (APM32F103VCS_MINI)
#include "Board_APM32F103VCS_MINI.h"

#else
#error "Please select first the APM32  board to be used (in board.h)"
#endif

#endif

