#pragma once
/*
 * This file is part of the libCEC(R) library.
 *
 * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
 * libCEC(R) is an original work, containing original code.
 *
 * libCEC(R) is a trademark of Pulse-Eight Limited.
 *
 * This program is dual-licensed; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301  USA
 *
 *
 * Alternatively, you can license this library under a commercial license,
 * please contact Pulse-Eight Licensing for more information.
 *
 * For more information contact:
 * Pulse-Eight Licensing       <license@pulse-eight.com>
 *     http://www.pulse-eight.com/
 *     http://www.pulse-eight.net/
 */

#include "env.h"
#include "p8-platform/threads/threads.h"
#include "p8-platform/util/buffer.h"
#include "p8-platform/util/timeutils.h"
#include <map>
#include "USBCECAdapterMessage.h"

namespace CEC
{
  class CUSBCECAdapterCommunication;
  class CCECAdapterMessageQueue;
  class CCECAdapterMessage;

  class CCECAdapterMessageQueueEntry
  {
  public:
    CCECAdapterMessageQueueEntry(CCECAdapterMessageQueue *queue, CCECAdapterMessage *message);
    virtual ~CCECAdapterMessageQueueEntry(void);

    /*!
     * @brief Signal waiting threads
     */
    void Broadcast(void);

    /*!
     * @brief Called when a message was received.
     * @param message The message that was received.
     * @return True when this message was handled by this entry, false otherwise.
     */
    bool MessageReceived(const CCECAdapterMessage &message);

    /*!
     * @brief Wait for a response to this command.
     * @param iTimeout The timeout to use while waiting.
     * @return True when a response was received before the timeout passed, false otherwise.
     */
    bool Wait(uint32_t iTimeout);

    /*!
     * @return True while a thread is waiting for a signal or isn't waiting yet, false otherwise.
     */
    bool IsWaiting(void);

    /*!
     * @return The msgcode of the command that was sent.
     */
    cec_adapter_messagecode MessageCode(void);

    /*!
     * @brief Check whether a message is a response to this command.
     * @param msg The message to check.
     * @return True when it's a response, false otherwise.
     */
    bool IsResponse(const CCECAdapterMessage &msg);
    bool IsResponseOld(const CCECAdapterMessage &msg);

    /*!
     * @return The command that was sent in human readable form.
     */
    const char *ToString(void) const;

    /*!
     * @brief Called when a 'command accepted' message was received.
     * @param message The message that was received.
     * @return True when the message was handled, false otherwise.
     */
    bool MessageReceivedCommandAccepted(const CCECAdapterMessage &message);

    /*!
     * @brief Called when a 'transmit succeeded' message was received.
     * @param message The message that was received.
     * @return True when the message was handled, false otherwise.
     */
    bool MessageReceivedTransmitSucceeded(const CCECAdapterMessage &message);

    /*!
     * @brief Called when a message that's not a 'command accepted' or 'transmit succeeded' message was received.
     * @param message The message that was received.
     * @return True when the message was handled, false otherwise.
     */
    bool MessageReceivedResponse(const CCECAdapterMessage &message);

    /*!
     * @brief Signals the waiting thread.
     */
    void Signal(void);

    bool ProvidesExtendedResponse(void);

    /*!
     * @return True when a fire and forget packet timed out or succeeded, false otherwise
     */
    bool TimedOutOrSucceeded(void) const;

    CCECAdapterMessageQueue *    m_queue;
    CCECAdapterMessage *         m_message;      /**< the message that was sent */
    uint8_t                      m_iPacketsLeft; /**< the amount of acks that we're waiting on */
    bool                         m_bSucceeded;   /**< true when the command received a response, false otherwise */
    bool                         m_bWaiting;     /**< true while a thread is waiting or when it hasn't started waiting yet */
    P8PLATFORM::CCondition<bool> m_condition;    /**< the condition to wait on */
    P8PLATFORM::CMutex           m_mutex;        /**< mutex for changes to this class */
    P8PLATFORM::CTimeout         m_queueTimeout;   /**< ack timeout for fire and forget commands */
  };

  class CCECAdapterMessageQueue : public P8PLATFORM::CThread
  {
    friend class CUSBCECAdapterCommunication;
    friend class CCECAdapterMessageQueueEntry;

  public:
    /*!
     * @brief Create a new message queue.
     * @param com The communication handler callback to use.
     * @param iQueueSize The outgoing message queue size.
     */
    CCECAdapterMessageQueue(CUSBCECAdapterCommunication *com);
    virtual ~CCECAdapterMessageQueue(void);

    /*!
     * @brief Signal and delete everything in the queue
     */
    void Clear(void);

    /*!
     * @brief Called when a message was received from the adapter.
     * @param msg The message that was received.
     */
    void MessageReceived(const CCECAdapterMessage &msg);

    /*!
     * @brief Adds received data to the current frame.
     * @param data The data to add.
     * @param iLen The length of the data to add.
     */
    void AddData(uint8_t *data, size_t iLen);

    /*!
     * @brief Transmit a command to the adapter and wait for a response.
     * @param msg The command to send.
     * @return True when written, false otherwise.
     */
    bool Write(CCECAdapterMessage *msg);

    bool ProvidesExtendedResponse(void);

    virtual void *Process(void);

    void CheckTimedOutMessages(void);

  private:
    CUSBCECAdapterCommunication *                            m_com;                    /**< the communication handler */
    P8PLATFORM::CMutex                                       m_mutex;                  /**< mutex for changes to this class */
    std::map<uint64_t, CCECAdapterMessageQueueEntry *>       m_messages;               /**< the outgoing message queue */
    P8PLATFORM::SyncedBuffer<CCECAdapterMessageQueueEntry *> m_writeQueue;             /**< the queue for messages that are to be written */
    uint64_t                                                 m_iNextMessage;           /**< the index of the next message */
    CCECAdapterMessage                                    *  m_incomingAdapterMessage; /**< the current incoming message that's being assembled */
    cec_command                                              m_currentCECFrame;        /**< the current incoming CEC command that's being assembled */
  };
}
