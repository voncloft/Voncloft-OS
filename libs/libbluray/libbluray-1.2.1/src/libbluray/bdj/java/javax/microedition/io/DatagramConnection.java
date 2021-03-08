/*
 * This file is part of libbluray
 * Copyright (C) 2019  VideoLAN
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library. If not, see
 * <http://www.gnu.org/licenses/>.
 */

package javax.microedition.io;

import java.io.IOException;

public interface DatagramConnection extends Connection {
    public abstract int getMaximumLength() throws IOException;
    public abstract int getNominalLength() throws IOException;
    public abstract Datagram newDatagram(int size) throws IOException;
    public abstract Datagram newDatagram(int size, String addr) throws IOException;
    public abstract Datagram newDatagram(byte[] buf, int size) throws IOException;
    public abstract Datagram newDatagram(byte[] buf, int size, String addr) throws IOException;
    public abstract void receive(Datagram dgram) throws IOException;
    public abstract void send(Datagram dgram) throws IOException;
}
