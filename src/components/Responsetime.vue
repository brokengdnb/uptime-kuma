<template>
    <span :class="className" :title="title">{{ response }}</span>
</template>

<script>
import { DOWN, MAINTENANCE, PENDING, UP } from "../util.ts";

export default {
    props: {
        /** Monitor this represents */
        monitor: {
            type: Object,
            default: null,
        },
        /** Type of monitor */
        type: {
            type: String,
            default: null,
        },
        /** Is this a pill? */
        pill: {
            type: Boolean,
            default: false,
        },
    },

    computed: {
        response() {
            /*if (this.type === "maintenance") {
                return this.$t("statusMaintenance");
            }

            let key = this.monitor.id;

            if (this.$root.uptimeList[key] !== undefined) {
                let result = Math.round(this.$root.uptimeList[key] * 10000) / 100;
                // Only perform sanity check on status page. See louislam/uptime-kuma#2628
                if (this.$route.path.startsWith("/status") && result > 100) {
                    return "100%";
                } else {
                    return result + "%";
                }
            }*/
            let key = this.monitor.id;

            if (this.$root.heartbeatList[key] !== undefined) {
                const average = array => (array && array.length) ? (array.reduce((sum, item) => sum + item, 0) / array.length) : undefined;

                var data = this.$root.heartbeatList[key].map(function (el, i) {
                    return el.ping
                    
                });

                // Only perform sanity check on status page. See louislam/uptime-kuma#2628
                if (this.$route.path.startsWith("/status") && result > 100) {
                    return "0";
                } else {
                    return average(data) + "%";
                }
            }

            
        },

        uptime() {
            if (this.type === "maintenance") {
                return this.$t("statusMaintenance");
            }

            let key = this.monitor.id + "_" + this.type;

            if (this.$root.uptimeList[key] !== undefined) {
                let result = Math.round(this.$root.uptimeList[key] * 10000) / 100;
                // Only perform sanity check on status page. See louislam/uptime-kuma#2628
                if (this.$route.path.startsWith("/status") && result > 100) {
                    return "100%";
                } else {
                    return result + "%";
                }
            }

            return this.$t("notAvailableShort");
        },

        color() {
            if (this.lastHeartBeat.status === MAINTENANCE) {
                return "maintenance";
            }

            if (this.lastHeartBeat.status === DOWN) {
                return "danger";
            }

            if (this.lastHeartBeat.status === UP) {
                return "primary";
            }

            if (this.lastHeartBeat.status === PENDING) {
                return "warning";
            }

            return "secondary";
        },

        lastHeartBeat() {
            if (this.monitor.id in this.$root.lastHeartbeatList && this.$root.lastHeartbeatList[this.monitor.id]) {
                return this.$root.lastHeartbeatList[this.monitor.id];
            }

            return {
                status: -1,
            };
        },

        className() {
            if (this.pill) {
                return `badge rounded-pill bg-${this.color}`;
            }

            return "";
        },

        title() {
            if (this.type === "ms") {
                return "response time";
            }
            if (this.type === "1y") {
                return `1${this.$t("-year")}`;
            }
            if (this.type === "720") {
                return `30${this.$t("-day")}`;
            }
            return `24${this.$t("-hour")}`;
        }
    },
};
</script>

<style>
.badge {
    min-width: 62px;
}
</style>
