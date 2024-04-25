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
            const average = array => (array && array.length) ? (array.reduce((sum, item) => sum + item, 0) / array.length) : undefined;
            let key = this.monitor.id;

            if (this.$root.heartbeatList[key] !== undefined) {

                var data = this.$root.heartbeatList[key].map(function (el, i) {
                    return el.ping;
                });

                if (data.length > 0) {
                    console.log(average(data));
                    return average(data).toString().split(".")[1] + " ms";
                }
                

                // Only perform sanity check on status page. See louislam/uptime-kuma#2628
               
                return null;// average(data).toString().split(".")[1] + " ms";
                
            }
        },

        color() {
         /*   if (this.lastHeartBeat > 500) {
                return "danger";
            }

            if (this.lastHeartBeat <= 100) {
                return "primary";
            }

            if (this.lastHeartBeat <= 500) {
                return "warning";
            }*/

            return "primary";
        },

        lastHeartBeat() {
            let key = this.monitor.id;

            if (key in this.$root.heartbeatList && this.$root.heartbeatList[key]) {


                console.log(this.$root.heartbeatList[key]);
                var data = this.$root.heartbeatList[key].map(function (el, i) {
                    return el.ping
                });

                if (data.length > 0) {
                    const average = array => (array && array.length) ? (array.reduce((sum, item) => sum + item, 0) / array.length) : undefined;


                    console.log(average(data).toString().split(".")[1]);

                    // Only perform sanity check on status page. See louislam/uptime-kuma#2628
                    return average(data).toString().split(".")[1];//average(data).toString().split(".")[1].toNumber();
                } else {
                    return -1;
                }
            }

            return -1;
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
