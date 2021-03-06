<template>
    <div
        ref="stageContainer"
        :class="{ 'soda-stage-container': true, 'first-container': stageIndex === 0, 'readonly': !editable || containerDisabled }"
    >
        <template v-if="!isOnlyOneContainer && containerLength - 1 !== containerIndex">
            <span class="connect-line left" :class="{ 'cruve': containerIndex === 0 }"></span>
            <span class="connect-line right" :class="{ 'cruve': containerIndex === 0 }"></span>
        </template>
        <h3 :class="{ 'container-title': true, 'first-ctitle': containerIndex === 0, [container.status]: container.status }" @click.stop="showContainerPanel">
            <status-icon type="container" :editable="editable" :container-disabled="containerDisabled" :status="container.status">
                {{ containerSerialNum }}
            </status-icon>
            <p class="container-name">
                <span :title="container.name">{{ container.status === 'PREPARE_ENV' ? $t('editPage.prepareEnv') : container.name }}</span>
            </p>
            <container-type :class="showCopyJob ? 'hover-hide' : ''" :container="container" v-if="!showCheckedToatal"></container-type>
            <span :title="$t('editPage.copyJob')" v-if="showCopyJob && !container.isError" class="bk-icon copyJob" @click.stop="copyContainer">
                <Logo name="copy" size="18"></Logo>
            </span>
            <i v-if="showCopyJob" @click.stop="deleteJob" class="add-plus-icon close" />
            <span @click.stop v-if="showCheckedToatal && canSkipElement">
                <bk-checkbox class="atom-canskip-checkbox" v-model="container.runContainer" :disabled="containerDisabled"></bk-checkbox>
            </span>
        </h3>
        <atom-list
            :container="container"
            :editable="editable"
            :is-preview="isPreview"
            :can-skip-element="canSkipElement"
            :stage-index="stageIndex"
            :container-index="containerIndex"
            :container-status="container.status"
            :container-disabled="containerDisabled"
        >
        </atom-list>
    </div>
</template>

<script>
    import { mapActions, mapGetters, mapState } from 'vuex'
    import { getOuterHeight } from '@/utils/util'
    import ContainerType from './ContainerType'
    import AtomList from './AtomList'
    import StatusIcon from './StatusIcon'
    import Logo from '@/components/Logo'

    export default {
        components: {
            StatusIcon,
            ContainerType,
            AtomList,
            Logo
        },
        props: {
            container: Object,
            stageIndex: Number,
            containerIndex: Number,
            stageLength: Number,
            containerLength: Number,
            stageDisabled: Boolean,
            editable: {
                type: Boolean,
                default: true
            },
            isPreview: {
                type: Boolean,
                default: false
            },
            canSkipElement: {
                type: Boolean,
                default: false
            }
        },
        data () {
            return {
                showContainerName: false,
                showAtomName: false
            }
        },
        computed: {
            ...mapState('atom', [
                'execDetail',
                'pipeline'
            ]),
            ...mapGetters('atom', [
                'isTriggerContainer',

                'getAllContainers'
            ]),
            showCheckedToatal () {
                const { isTriggerContainer, container, $route } = this
                return $route.path.indexOf('preview') > 0 && !isTriggerContainer(container)
            },
            showCopyJob () {
                const { isTriggerContainer, container, $route } = this
                return $route.path.indexOf('edit') > 0 && !isTriggerContainer(container) && this.editable
            },
            containerSerialNum () {
                return `${this.stageIndex + 1}-${this.containerIndex + 1}`
            },
            isOnlyOneContainer () {
                return this.containerLength === 1
            },
            projectId () {
                return this.$route.params.projectId
            },
            containerDisabled () {
                return !!(this.container.jobControlOption && this.container.jobControlOption.enable === false) || this.stageDisabled
            }
        },
        watch: {
            'container.elements.length': function (newVal, oldVal) {
                if (newVal !== oldVal) {
                    this.$forceUpdate()
                }
            },
            'container.runContainer' (newVal) {
                const { container, updateContainer } = this
                const { elements } = container
                if (this.containerDisabled && newVal) return
                elements.filter(item => (item.additionalOptions === undefined || item.additionalOptions.enable)).map(item => {
                    item.canElementSkip = newVal
                    return false
                })
                updateContainer({
                    container,
                    newParam: {
                        elements
                    }
                })
            }
        },
        mounted () {
            this.updateCruveConnectHeight()
            if (this.containerDisabled) {
                this.container.runContainer = false
            }
        },
        updated () {
            this.updateCruveConnectHeight()
        },
        methods: {
            ...mapActions('atom', [
                'togglePropertyPanel',
                'addAtom',
                'deleteAtom',
                'updateContainer',
                'setPipelineEditing',
                'deleteContainer',
                'deleteStage'
            ]),
            deleteJob () {
                const { containerIndex, stageIndex } = this
                const containers = this.pipeline.stages[stageIndex].containers || []

                if (containers.length === 1) {
                    this.deleteStage({
                        stageIndex
                    })
                } else {
                    this.deleteContainer({
                        stageIndex,
                        containerIndex
                    })
                }
            },
            updateCruveConnectHeight () {
                if (!this.$refs.stageContainer) {
                    return
                }
                const height = `${getOuterHeight(this.$refs.stageContainer) - 12}px`
                Array.from(this.$refs.stageContainer.querySelectorAll('.connect-line')).map(el => {
                    el.style.height = height
                })
            },
            showContainerPanel () {
                const { stageIndex, containerIndex } = this
                this.togglePropertyPanel({
                    isShow: true,
                    editingElementPos: {
                        stageIndex,
                        containerIndex
                    }
                })
            },
            copyContainer () {
                try {
                    const copyContainer = JSON.parse(JSON.stringify(this.container))
                    const { containerId, ...container } = copyContainer
                    container.elements = container.elements.map(element => {
                        const { id, ...ele } = element
                        return ele
                    })
                    this.pipeline.stages[this.stageIndex].containers.splice(this.containerIndex + 1, 0, JSON.parse(JSON.stringify(container)))
                    this.setPipelineEditing(true)
                } catch (e) {
                    console.error(e)
                    this.$showTips({
                        theme: 'error',
                        message: this.$t('editPage.copyJobFail')
                    })
                }
            }
        }
    }
</script>

<style lang="scss">
    @import "./Stage";
    .soda-stage-container {
        text-align: left;
        margin: 0 $StageMargin/2 26px $StageMargin/2;
        position: relative;

        // 实心圆点
        &:after {
            content: '';
            width: $dotR;
            height: $dotR;
            position: absolute;
            right: -$dotR / 2;
            top: $itemHeight / 2 - ($dotR / 2 - 1);
            background: $primaryColor;
            border-radius: 50%;
        }
        // 三角箭头
        &:before {
            content: '';
            border: $angleSize solid transparent;
            border-left-color: $primaryColor;
            height: 0;
            width: 0;
            position: absolute;
            left: -$angleSize;
            top: $itemHeight / 2 - $angleSize + 1;
            z-index: 2;
        }

        &.first-container {
            margin-left: 0;
            &:before,
            .container-title:before {
                display: none;
            }
        }

        .container-title {
            display: flex;
            height: $itemHeight;
            background: #33333f;
            color: white;
            font-size: 14px;
            align-items: center;
            position: relative;
            margin: 0 0 16px 0;
            width: 240px;
            z-index: 3;
            > .container-name {
                @include ellipsis();
                flex: 1;
                padding: 0 12px;
                span:hover {
                    color: $primaryColor;
                }
            }

            .atom-canskip-checkbox {
                margin-right: 6px;
            }
            input[type=checkbox] {
                border-radius: 3px;
            }
            .debug-btn {
                position: absolute;
                height: 100%;
                right: 0;
            }
            .copyJob {
                display: none;
                margin-right: 10px;
                fill: #c4c6cd;
                cursor: pointer;
                &:hover {
                    fill: $primaryColor;
                }
            }
            .close {
                @include add-plus-icon(#2E2E3A, #2E2E3A, #c4c6cd, 16px, true);
                @include add-plus-icon-hover($dangerColor, $dangerColor, white);
                border: none;
                display: none;
                margin-right: 10px;
                transform: rotate(45deg);
                cursor: pointer;
                &:before, &:after {
                    left: 7px;
                    top: 4px;
                }
            }

            &:hover {
                .copyJob, .close {
                    display: block;
                }
                .hover-hide {
                    display: none;
                }
            }

            // 实线
            &:before,
            &:after {
                content: '';
                position: absolute;
                border-top: 2px $lineStyle $primaryColor;
                width: $StagePadding;
                top: $itemHeight / 2;
                left: -$StagePadding;
            }
            &:after {
                right: -$StagePadding;
                left: auto;
            }

            &:not(.first-ctitle) {
                &:before,
                &:after {
                    width: $shortLine;
                    left: -$shortLine;
                }

                &:after {
                    left: auto;
                    right: -$shortLine;
                }
            }
        }
        .connect-line {
            position: absolute;
            top: $itemHeight / 2 + 1 + $lineRadius;
            @include cruve-connect ($lineRadius, $lineStyle, $primaryColor, false);
            &.left {
                left: -$StageMargin / 2 + (2 * $lineRadius);
            }
            &.right {
                @include cruve-connect ($lineRadius, $lineStyle, $primaryColor, true);
                right: -$StageMargin / 2  + (2 * $lineRadius);
            }
            &:not(.cruve) {
                &:before {
                    top: -$itemHeight / 2 + $lineRadius + 1;
                    transform: rotate(0);
                    border-radius: 0;
                }
            }
        }
    }

    .readonly {
        .connect-line {
            &.left,
            &.right {
                border-color: $lineColor;
                &:before {
                    border-right-color: $lineColor;
                }
                &:after {
                    border-bottom-color: $lineColor;
                }
            }
        }
        &:after {
            background: $lineColor;
        }
        // 三角箭头
        &:before {
            border-left-color: $lineColor;
        }
        .container-title {
            cursor: pointer;
            background-color: $fontWeightColor;

            &.RUNNING {
                background-color: $loadingColor;
            }
            &.PREPARE_ENV {
                background-color: $loadingColor;
            }
            &.CANCELED, &.REVIEWING, &.REVIEW_ABORT {
                background-color: $cancelColor;
            }
            &.FAILED, &.HEARTBEAT_TIMEOUT {
                background-color: $dangerColor;
            }
            &.SUCCEED {
                background-color: $successColor;
            }
            &:before,
            &:after {
                border-top-color: $lineColor;
            }
            > .container-name span:hover {
                color: white;
            }
        }
    }
</style>
