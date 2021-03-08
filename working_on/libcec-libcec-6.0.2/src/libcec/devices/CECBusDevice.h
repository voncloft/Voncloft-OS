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
#include "p8-platform/threads/mutex.h"
#include <set>
#include <map>
#include <string>
#include <memory>

namespace CEC
{
  class CCECClient;
  class CCECProcessor;
  class CCECCommandHandler;
  class CCECAudioSystem;
  class CCECPlaybackDevice;
  class CCECRecordingDevice;
  class CCECTuner;
  class CCECTV;
  typedef std::shared_ptr<CCECClient> CECClientPtr;

  class CResponse
  {
  public:
    CResponse(cec_opcode opcode);
    ~CResponse(void);

    bool Wait(uint32_t iTimeout);
    void Broadcast(void);

  private:
    cec_opcode         m_opcode;
    P8PLATFORM::CEvent m_event;
  };

  class CWaitForResponse
  {
  public:
    CWaitForResponse(void);
    ~CWaitForResponse(void);

    void Clear();
    bool Wait(cec_opcode opcode, uint32_t iTimeout = CEC_DEFAULT_TRANSMIT_WAIT);
    void Received(cec_opcode opcode);

  private:
    CResponse *GetEvent(cec_opcode opcode);

    P8PLATFORM::CMutex               m_mutex;
    std::map<cec_opcode, CResponse*> m_waitingFor;
  };

  class CCECBusDevice
  {
    friend class CCECProcessor;

  public:
    CCECBusDevice(CCECProcessor *processor, cec_logical_address address, uint16_t iPhysicalAddress = CEC_INVALID_PHYSICAL_ADDRESS);
    virtual ~CCECBusDevice(void);

    virtual bool                  ReplaceHandler(bool bActivateSource = true);

    // TODO use something smarter than this
    /*!
     * @brief Get the command handler for this device. Call MarkHandlerReady() when done with it.
     * @return The current handler.
     */
    virtual CCECCommandHandler *  GetHandler(void);

    /*!
     * @brief To be called after GetHandler(), when no longer using it.
     */
    virtual void                  MarkHandlerReady(void) { MarkReady(); }

    virtual CCECProcessor *       GetProcessor(void) const      { return m_processor; }
    virtual uint64_t              GetLastActive(void) const     { return m_iLastActive; }
    virtual cec_device_type       GetType(void) const           { return m_type; }
    virtual cec_logical_address   GetLogicalAddress(void) const { return m_iLogicalAddress; }
    virtual const char*           GetLogicalAddressName(void) const;
    virtual bool                  IsPresent(void);
    virtual bool                  IsHandledByLibCEC(void);
    virtual bool                  IsActive(bool suppressPoll = true);

    virtual bool                  HandleCommand(const cec_command &command);
    virtual bool                  IsUnsupportedFeature(cec_opcode opcode);
    virtual void                  SetUnsupportedFeature(cec_opcode opcode);

    virtual bool                  TransmitKeypress(const cec_logical_address initiator, cec_user_control_code key, bool bWait = true);
    virtual bool                  TransmitKeyRelease(const cec_logical_address initiator, bool bWait = true);

    virtual cec_version           GetCecVersion(const cec_logical_address initiator, bool bUpdate = false);
    virtual void                  SetCecVersion(const cec_version newVersion);
    virtual bool                  RequestCecVersion(const cec_logical_address initiator, bool bWaitForResponse = true);
    virtual bool                  TransmitCECVersion(const cec_logical_address destination, bool bIsReply);

    virtual std::string           GetMenuLanguage(const cec_logical_address initiator, bool bUpdate = false);
    virtual void                  SetMenuLanguage(const std::string& strLanguage);
    virtual void                  SetMenuLanguage(const cec_menu_language &menuLanguage);
    virtual bool                  RequestMenuLanguage(const cec_logical_address initiator, bool bWaitForResponse = true);
    virtual bool                  TransmitSetMenuLanguage(const cec_logical_address destination, bool bIsReply);

    virtual bool                  TransmitOSDString(const cec_logical_address destination, cec_display_control duration, const char *strMessage, bool bIsReply);

    virtual std::string           GetCurrentOSDName(void);
    virtual std::string           GetOSDName(const cec_logical_address initiator, bool bUpdate = false);
    virtual void                  SetOSDName(const std::string& strName);
    virtual bool                  RequestOSDName(const cec_logical_address source, bool bWaitForResponse = true);
    virtual bool                  TransmitOSDName(const cec_logical_address destination, bool bIsReply);

    virtual uint16_t              GetCurrentPhysicalAddress(void);
    virtual bool                  HasValidPhysicalAddress(void);
    virtual uint16_t              GetPhysicalAddress(const cec_logical_address initiator, bool bSuppressUpdate = false);
    virtual bool                  SetPhysicalAddress(uint16_t iNewAddress);
    virtual bool                  RequestPhysicalAddress(const cec_logical_address initiator, bool bWaitForResponse = true);
    virtual bool                  TransmitPhysicalAddress(bool bIsReply);

    virtual cec_power_status      GetCurrentPowerStatus(void);
    virtual cec_power_status      GetPowerStatus(const cec_logical_address initiator, bool bUpdate = false);
    virtual void                  SetPowerStatus(const cec_power_status powerStatus);
    virtual void                  OnImageViewOnSent(bool bSentByLibCEC);
    virtual bool                  ImageViewOnSent(void);
    virtual bool                  RequestPowerStatus(const cec_logical_address initiator, bool bUpdate, bool bWaitForResponse = true);
    virtual bool                  TransmitPowerState(const cec_logical_address destination, bool bIsReply);

    virtual cec_vendor_id         GetCurrentVendorId(void);
    virtual cec_vendor_id         GetVendorId(const cec_logical_address initiator, bool bUpdate = false);
    virtual const char *          GetVendorName(const cec_logical_address initiator, bool bUpdate = false);
    virtual bool                  SetVendorId(uint64_t iVendorId);
    virtual bool                  RequestVendorId(const cec_logical_address initiator, bool bWaitForResponse = true);
    virtual bool                  TransmitVendorID(const cec_logical_address destination, bool bSendAbort, bool bIsReply);

    virtual cec_bus_device_status GetCurrentStatus(void) { return GetStatus(false, true); }
    virtual cec_bus_device_status GetStatus(bool bForcePoll = false, bool bSuppressPoll = false);
    virtual void                  SetDeviceStatus(const cec_bus_device_status newStatus, cec_version libCECSpecVersion = CEC_VERSION_1_4);
    virtual void                  ResetDeviceStatus(bool bClientUnregistered = false);
    virtual bool                  TransmitPoll(const cec_logical_address destination, bool bUpdateDeviceStatus);
    virtual void                  HandlePoll(const cec_logical_address destination);
    virtual void                  HandlePollFrom(const cec_logical_address initiator);
    virtual bool                  HandleReceiveFailed(void);

    virtual cec_menu_state        GetMenuState(const cec_logical_address initiator);
    virtual void                  SetMenuState(const cec_menu_state state);
    virtual bool                  TransmitMenuState(const cec_logical_address destination, bool bIsReply);

    virtual bool                  ActivateSource(uint64_t iDelay = 0);
    virtual bool                  IsActiveSource(void) const    { return m_bActiveSource; }
    virtual bool                  RequestActiveSource(bool bWaitForResponse = true);
    virtual void                  MarkAsActiveSource(void);
    virtual void                  MarkAsInactiveSource(bool bClientUnregistered = false);
    virtual bool                  TransmitActiveSource(bool bIsReply);
    virtual bool                  TransmitImageViewOn(void);
    virtual bool                  TransmitInactiveSource(void);
    virtual bool                  TransmitPendingActiveSourceCommands(void);
    virtual void                  SetActiveRoute(uint16_t iRoute);
    virtual void                  SetStreamPath(uint16_t iNewAddress, uint16_t iOldAddress = CEC_INVALID_PHYSICAL_ADDRESS);

    virtual bool                  PowerOn(const cec_logical_address initiator);
    virtual bool                  Standby(const cec_logical_address initiator);

    virtual bool                  SystemAudioModeRequest(void);
    virtual bool                  TransmitVolumeUp(const cec_logical_address source, bool bSendRelease = true);
    virtual bool                  TransmitVolumeDown(const cec_logical_address source, bool bSendRelease = true);
    virtual bool                  TransmitMuteAudio(const cec_logical_address source);

    virtual bool                  TryLogicalAddress(cec_version libCECSpecVersion = CEC_VERSION_1_4);

    CECClientPtr                  GetClient(void);
    void                          SignalOpcode(cec_opcode opcode);
    bool                          WaitForOpcode(cec_opcode opcode);

    void                          SetActiveSourceSent(bool setto = true);
    bool                          ActiveSourceSent(void) const;

           CCECAudioSystem *      AsAudioSystem(void);
    static CCECAudioSystem *      AsAudioSystem(CCECBusDevice *device);
           CCECPlaybackDevice *   AsPlaybackDevice(void);
    static CCECPlaybackDevice *   AsPlaybackDevice(CCECBusDevice *device);
           CCECRecordingDevice *  AsRecordingDevice(void);
    static CCECRecordingDevice *  AsRecordingDevice(CCECBusDevice *device);
           CCECTuner *            AsTuner(void);
    static CCECTuner *            AsTuner(CCECBusDevice *device);
           CCECTV *               AsTV(void);
    static CCECTV *               AsTV(CCECBusDevice *device);

  protected:
    void CheckVendorIdRequested(const cec_logical_address source);
    void MarkBusy(void);
    void MarkReady(void);

    bool NeedsPoll(void);

    cec_device_type       m_type;
    std::string           m_strDeviceName;
    uint16_t              m_iPhysicalAddress;
    uint16_t              m_iStreamPath;
    cec_logical_address   m_iLogicalAddress;
    cec_power_status      m_powerStatus;
    std::string           m_menuLanguage;
    CCECProcessor      *  m_processor;
    CCECCommandHandler *  m_handler;
    cec_vendor_id         m_vendor;
    bool                  m_bReplaceHandler;
    cec_menu_state        m_menuState;
    bool                  m_bActiveSource;
    int64_t               m_iLastActive;
    int64_t               m_iLastPowerStateUpdate;
    cec_version           m_cecVersion;
    cec_bus_device_status m_deviceStatus;
    std::set<cec_opcode>  m_unsupportedFeatures;
    P8PLATFORM::CMutex    m_mutex;
    P8PLATFORM::CMutex    m_handlerMutex;
    P8PLATFORM::CEvent    m_replacing;
    unsigned              m_iHandlerUseCount;
    bool                  m_bAwaitingReceiveFailed;
    bool                  m_bVendorIdRequested;
    CWaitForResponse     *m_waitForResponse;
    bool                  m_bImageViewOnSent;
    bool                  m_bActiveSourceSent;
  };
};
