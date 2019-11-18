<template>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-3">
                <reportssidebar :all_reports="reports" />
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
            reports: [],
            selectedReport: []
        }
    },
    components: { reportssidebar, showtable }
}
</script>

<style scoped>

</style>