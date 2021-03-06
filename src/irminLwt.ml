(*
 * Copyright (c) 2013 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Lwt
open IrminTypes

module Key = IrminKey.SHA1
module Value = IrminValue.Make(Key)(IrminValue.Blob(Key))
module Tag = IrminTag

module Key_store = IrminMemory.Key_store(Key)
module Value_store = IrminMemory.Value_store(Key)(Value)
module Tag_store = IrminMemory.Tag_store(Tag)(Key)

module Client = IrminProtocol.Client(Key)(Value)(Tag)

module MemoryServer =
  IrminProtocol.Server(Key)(Value)(Tag)(Key_store)(Value_store)(Tag_store)

module Disk =
  IrminProtocol.Disk(Key)(Value)(Tag)
