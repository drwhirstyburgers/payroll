<template>
    <transition name="modal">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <div class="modal-container">

                    <div class="modal-header">
                        <slot name="header">
                            <h4>Looks like there are some new job groups!</h4><br />
                        </slot>
                    </div>

                    <div class="modal-body">
                        <slot name="body">
                          <h6 v-if="blankError">There can be no blanks, please try again!</h6>
                            <div v-for="group in jobGroups" v-bind:group="group" v-bind:key="group.key" class="card">
                                <div class="card-body">
                                    <label>Name: {{ group.name }}</label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroup-sizing-default">Wage</span>
                                        </div>
                                        <input v-model="group.wage" type="number" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <button v-on:click="submitNewGroups" type="button" class="btn btn-outline-success float-right">Submit</button>
                        </slot>
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>

<script>
export default {
    data() {
        return {
            jobGroups: this.job_groups,
            blankError: false
        }
    },
    props: ['job_groups', 'blank_error'],
    watch: {
      blank_error: function(){
        this.blankError = true
      }
    },
    methods: {
        submitNewGroups(){
            let check = this.checkForNull(this.jobGroups)
            if(check.length > 0){
              this.blankError = true
            }
            const updatedJobGroups = this.jobGroups
            this.$emit('updated', updatedJobGroups)
        },
        checkForNull(job_groups){
          return job_groups.filter(jg => jg.wage == null || jg.wage == undefined || jg.wage == '' )
        }
    }
}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}
.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}
.modal-container {
  width: 500px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}
.modal-body {
  margin: 20px 0;
}
.modal-default-button {
  float: right;
}
.modal-enter {
  opacity: 0;
}
.modal-leave-active {
  opacity: 0;
}
.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>