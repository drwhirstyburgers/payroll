<template>
    <div class="container-fluid">
        <div class="row" id="indexRow">
            <div class="col-lg-3" id="sideNav">
                <reportssidebar v-on:selected="passReport" :all_reports="reports" />
            </div>
            <div class="col-lg-9">
                <showtable :one_report="selectedReport" />
            </div>
        </div>
    </div>
</template>

<script>
import reportssidebar from './reportssidebar'
import showtable from '../tables/showtable'

export default {
    data() {
        return {
            reports: this.all_reports,
            selectedReport: []
        }
    },
    props: ['all_reports'],
    components: { reportssidebar, showtable },
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

#indexRow {
    height: 800px;
}
</style>