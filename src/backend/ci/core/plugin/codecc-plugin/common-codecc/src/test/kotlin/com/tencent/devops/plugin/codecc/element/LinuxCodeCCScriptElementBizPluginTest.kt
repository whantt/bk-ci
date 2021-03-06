/*
 * Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
 *
 * BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
 *
 * A copy of the MIT License is included in this file.
 *
 *
 * Terms of the MIT License:
 * ---------------------------------------------------
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.tencent.devops.plugin.codecc.element

import com.tencent.devops.common.pipeline.enums.BuildScriptType
import com.tencent.devops.common.pipeline.enums.ChannelCode
import com.tencent.devops.common.pipeline.pojo.element.agent.LinuxCodeCCScriptElement
import com.tencent.devops.plugin.codecc.pojo.coverity.ProjectLanguage
import org.junit.Assert
import org.junit.Test

class LinuxCodeCCScriptElementBizPluginTest {

    private val plugin = LinuxCodeCCScriptElementBizPlugin()

    private val pipelineId = "p-123"
    private val projectId = "test"
    private val pipelineName = "codecc Pipeline"
    private val userId = "admin"
    private val element = LinuxCodeCCScriptElement(
        name = "exe",
        id = "1",
        status = "1",
        script = "echo hello",
        scanType = "1",
        scriptType = BuildScriptType.SHELL,
        codeCCTaskCnName = "demo",
        asynchronous = true,
        path = "/tmp/codecc",
        languages = listOf(ProjectLanguage.JAVA)
    )

    @Test
    fun afterCreate() {
        plugin.afterCreate(element, projectId, pipelineId, pipelineName, userId, ChannelCode.BS)
    }

    @Test
    fun beforeDelete() {
        plugin.beforeDelete(element, userId, pipelineId)
    }

    @Test
    fun elementClass() {
        Assert.assertEquals(
            LinuxCodeCCScriptElement::class.java,
            plugin.elementClass()
        )
    }

    @Test
    fun checkOne() {
        plugin.check(element, 1)
        plugin.check(element, 0)
    }

    @Test(expected = IllegalArgumentException::class)
    fun checkMoreOne() {
        plugin.check(element, 2)
    }
}