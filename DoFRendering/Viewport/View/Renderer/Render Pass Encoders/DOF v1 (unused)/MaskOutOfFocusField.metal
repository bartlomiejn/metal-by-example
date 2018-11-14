//
//  MaskOutOfFocusField.metal
//  DoFRendering
//
//  Created by Bartłomiej Nowak on 14/11/2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include "../TextureMappingVertex.h"

constexpr sampler texSampler(address::clamp_to_zero, filter::linear, coord::normalized);

/// Masks RGB out of focus field using depth texture as mask.
fragment half4
mask_outoffocus_field(TextureMappingVertex mappingVertex [[stage_in]],
                      texture2d<float, access::sample> colorTexture [[texture(0)]],
                      depth2d<float, access::sample> depthTexture [[texture(1)]])
{
    float4 colorFrag = colorTexture.sample(texSampler, mappingVertex.textureCoordinate);
    colorFrag.a = depthTexture.sample(texSampler, mappingVertex.textureCoordinate);
    return half4(colorFrag);
}

