/* runpe.vala
 *
 * Copyright (C) 2011 Nikolay Orlyuk
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
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Nikolay Orlyuk <virkony@gmail.com>
 */

using Posix;
using Magic;

bool is_mono(string filename) {
    var magic = Magic.Magic();
    magic.load();

    var desc = magic.file(filename);
    assert (desc != null);
    return (Posix.strstr(desc, "Mono") != null);
}

string[] build_args(string interp, string[] old_args)
{
    assert(old_args.length > 0);
    var args = new string[old_args.length];
    args[0] = interp;
    for(var i = 1; i < old_args.length; ++i)
    {
        args[i] = old_args[i];
    }
    return args;
}

int main(string[] args) {
    assert(args.length > 1);

    var pe = args[1];
    unowned string? interp = is_mono(pe) ? "mono" : "wine";

    var status = Posix.execvp(interp, build_args(interp, args));
    assert (status != -1);
    return 1;
}
