<template>
    <div class="container-fluid" id="show-container">
        <div class="row" id="indexRow">
            <div class="col-lg-2" id="sideNav">
                <reportssidebar v-on:selected="passReport" :all_reports="reports" />
            </div>
            <div class="col-lg-9">
                <showtable :one_report="selectedReport" />
            </div>
            <div class="col-lg-2">
                <console />
            </div>
        </div>
    </div>
</template>

<script>
import reportssidebar from './reportssidebar'
import console from './console'
import showtable from '../tables/showtable'

export default {
    data() {
        return {
            reports: this.all_reports,
            selectedReport: []
        }
    },
    props: ['all_reports'],
    components: { reportssidebar, showtable, console },
    methods: {
        passReport(reportPicked){
            this.selectedReport = reportPicked
        }
    }
}
</script>

<style scoped>
#sideNav {
    padding: 0px 0px 0px 0px;
    max-width: 300px;
}
</style>