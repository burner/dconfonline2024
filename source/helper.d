module helper;

import std.experimental.allocator;
import std.experimental.allocator.building_blocks.allocator_list
    : AllocatorList;
import std.experimental.allocator.building_blocks.bitmapped_block
    : BitmappedBlock;
import std.experimental.allocator.building_blocks.bucketizer : Bucketizer;
import std.experimental.allocator.building_blocks.free_list : FreeList;
import std.experimental.allocator.building_blocks.segregator : Segregator;
import std.experimental.allocator.gc_allocator : GCAllocator;
import std.experimental.allocator.mallocator;
import std.algorithm.comparison : max;

alias FList = FreeList!(Mallocator, 0, unbounded);
alias Allocator = Segregator!(
    8, FreeList!(Mallocator, 0, 8),
    128, Bucketizer!(FList, 1, 128, 16),
    256, Bucketizer!(FList, 129, 256, 32),
    512, Bucketizer!(FList, 257, 512, 64),
    1024, Bucketizer!(FList, 513, 1024, 128),
    2048, Bucketizer!(FList, 1025, 2048, 256),
    3584, Bucketizer!(FList, 2049, 3584, 512),
    4072 * 1024, AllocatorList!(
        (n) => BitmappedBlock!(4096)(
                cast(ubyte[])(Mallocator.instance.allocate(
                    max(n, 4072 * 1024))))),
    Mallocator
);
